import sys
with open(sys.argv[1]) as f:
    contigs = [l.strip() for l in f if not l.startswith('>')]
    contigs.sort(key=len, reverse=True)
    total = sum(len(i) for i in contigs)
    seen = 0
    for i in contigs:
        if seen + len(i) >= total / 2:
            print(len(i))
            break
        seen += len(i)
