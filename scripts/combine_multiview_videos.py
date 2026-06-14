from pathlib import Path

import cv2


def resize_to_width(frame, width):
    height, current_width = frame.shape[:2]
    if current_width == width:
        return frame
    scale = width / current_width
    return cv2.resize(frame, (width, round(height * scale)), interpolation=cv2.INTER_AREA)


def combine_pair(index):
    folder = Path("hyx") / f"multiview{index}"
    color_path = folder / "1.mp4"
    depth_path = folder / "1-depth.mp4"
    output_path = folder / "combined.mp4"

    color = cv2.VideoCapture(str(color_path))
    depth = cv2.VideoCapture(str(depth_path))
    if not color.isOpened():
        raise RuntimeError(f"Could not open {color_path}")
    if not depth.isOpened():
        raise RuntimeError(f"Could not open {depth_path}")

    fps = color.get(cv2.CAP_PROP_FPS) or depth.get(cv2.CAP_PROP_FPS) or 30
    color_frames = int(color.get(cv2.CAP_PROP_FRAME_COUNT))
    depth_frames = int(depth.get(cv2.CAP_PROP_FRAME_COUNT))
    frame_count = min(color_frames, depth_frames)

    ok_color, color_frame = color.read()
    ok_depth, depth_frame = depth.read()
    if not ok_color or not ok_depth:
        raise RuntimeError(f"Could not read first frame for multiview{index}")

    target_width = max(color_frame.shape[1], depth_frame.shape[1])
    color_frame = resize_to_width(color_frame, target_width)
    depth_frame = resize_to_width(depth_frame, target_width)
    output_height = color_frame.shape[0] + depth_frame.shape[0]

    fourcc = cv2.VideoWriter_fourcc(*"mp4v")
    writer = cv2.VideoWriter(str(output_path), fourcc, fps, (target_width, output_height))
    if not writer.isOpened():
        raise RuntimeError(f"Could not create {output_path}")

    written = 0
    while ok_color and ok_depth and written < frame_count:
        color_frame = resize_to_width(color_frame, target_width)
        depth_frame = resize_to_width(depth_frame, target_width)
        if color_frame.shape[1] != depth_frame.shape[1]:
            raise RuntimeError(f"Width mismatch while writing multiview{index}")
        stacked = cv2.vconcat([color_frame, depth_frame])
        writer.write(stacked)
        written += 1
        ok_color, color_frame = color.read()
        ok_depth, depth_frame = depth.read()

    color.release()
    depth.release()
    writer.release()

    print(
        f"{output_path}: {written} frames, {fps:.3f} fps, "
        f"{target_width}x{output_height}"
    )


def main():
    for index in range(1, 4):
        combine_pair(index)


if __name__ == "__main__":
    main()
