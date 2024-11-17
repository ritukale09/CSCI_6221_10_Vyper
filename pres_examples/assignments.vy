@external
def do_loop(a: int128):
    for i: int128 in [0, 1, 2, 3, 4, 5]:
        if i == a:
            break
        elif i != a:
            continue
        else:
            pass