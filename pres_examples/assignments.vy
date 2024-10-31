CONS_TRUE: constant(bool) = True
def do_math():
    x: int128 = 5 + 5
    z: int128 = 5 * 5
    y: int128 = 15 - 5
    w: int128 = 50//5
    always_true: bool = CONS_TRUE
    bool_expr1: bool = True and False   # False
    bool_expr2: bool = True or False    # True
   
#this will work
def do_loop(a: uint256):
    for i: uint256 in [1, 2, 3, 4, 5]:
        if i == a:
            break
        elif i != a:
            continue
        else:
            pass

def do_while():
    count : int128 = 0
    while(count<10):
        count = count + 1