import sys

with open(sys.argv[1], 'ab', buffering=0) as f:
    print(f"Writing to {sys.argv}")

    while True:
        try:
            line = sys.stdin.buffer.read(1)
            f.write(line)
        except KeyboardInterrupt:
            continue


