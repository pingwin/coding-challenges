if __name__ == '__main__':
    tests = [
            # (name, s, answer, data),
            ("1", 7, 2, [2, 1, 5, 2, 3, 2]),
            ("2", 7, 1, [2, 1, 5, 2, 8]),
            ("3", 8, 3, [3, 4, 1, 1, 6]),
            ("Return 0 if no such subarray exists", 9, 0, [4, 1, 1, 1]),
            ]
    for (name, s, answer, data) in tests:
        shortest = len(data)+1
        for i in range(0, len(data)+1):
            for l in range(0, len(data)+1):
                if sum(data[i:l]) >= s:
                    if abs(i-l) < shortest:
                        shortest = abs(i-l)
        if shortest == len(data)+1:
            shortest = 0
        assert(shortest == answer)

