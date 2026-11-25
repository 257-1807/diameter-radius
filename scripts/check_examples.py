#!/usr/bin/env python3
"""Check the conjectures on labelled connected graphs of orders 2–6 and on paths."""

from collections import deque
from itertools import combinations
from math import isqrt


def invariants(neighbours):
    """Return (radius, diameter) using BFS from each vertex, or None if disconnected."""
    size = len(neighbours)
    eccentricities = []
    for source in range(size):
        distances = [-1] * size
        distances[source] = 0
        queue = deque([source])
        while queue:
            vertex = queue.popleft()
            for other in neighbours[vertex]:
                if distances[other] == -1:
                    distances[other] = distances[vertex] + 1
                    queue.append(other)
        if -1 in distances:
            return None
        eccentricities.append(max(distances))
    return min(eccentricities), max(eccentricities)


def certify(radius, diameter):
    # numerator / denominator is a lower bound on sqrt(radius).
    # Both bases exceed one, so the integer comparisons imply the desired bounds.
    denominator = 256
    numerator = isqrt(radius * denominator**2)
    if diameter**denominator > 3**numerator:
        raise ValueError(f"Base 3 check inconclusive at r={radius}, D={diameter}")
    if diameter**(2 * denominator) > 8**numerator:
        raise ValueError(f"Base sqrt(8) check inconclusive at r={radius}, D={diameter}")


def check_graphs():
    counts = []
    for size in range(2, 7):
        edges = list(combinations(range(size), 2))
        pairs = set()
        connected = 0
        for mask in range(1 << len(edges)):
            neighbours = [[] for _ in range(size)]
            for bit, (left, right) in enumerate(edges):
                if mask & (1 << bit):
                    neighbours[left].append(right)
                    neighbours[right].append(left)
            result = invariants(neighbours)
            if result is not None:
                connected += 1
                pairs.add(result)
        for radius, diameter in sorted(pairs):
            certify(radius, diameter)
        print(f"n={size}  connected={connected}  (radius, diameter)={sorted(pairs)}")
        counts.append(connected)
    print(f"Total connected labelled graphs checked: {sum(counts)}")


def check_paths():
    for size in range(2, 66):
        neighbours = [[] for _ in range(size)]
        for left in range(size - 1):
            neighbours[left].append(left + 1)
            neighbours[left + 1].append(left)
        result = invariants(neighbours)
        if result != (size // 2, size - 1):
            raise ValueError(f"Unexpected path invariants for n={size}: {result}")
        certify(*result)
        if size == 9:
            print(f"P9: radius={result[0]}, diameter={result[1]}, sharp equality: 8 = (sqrt(8))^2")
    print("All paths of orders 2 through 65 passed both integer checks.")


if __name__ == "__main__":
    check_graphs()
    check_paths()
