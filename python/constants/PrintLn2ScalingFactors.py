from decimal import Decimal
from decimal import getcontext
from decimal import ROUND_FLOOR
from decimal import ROUND_CEILING


MAX_PRECISION = 127


def ln(n):
    return Decimal(n).ln()


def log2(n):
    return ln(n)/ln(2)


def floor(d):
    return int(d.to_integral_exact(rounding=ROUND_FLOOR))


def ceiling(d):
    return int(d.to_integral_exact(rounding=ROUND_CEILING))


getcontext().prec = 100


maxVal = floor(log2(2**(256-MAX_PRECISION)-1)*2**MAX_PRECISION)


LN2_NUMERATOR   = (2**256-1)//maxVal
LN2_DENOMINATOR = ceiling(LN2_NUMERATOR/ln(2))


print('    uint256 private constant LN2_NUMERATOR   = 0x{:x};'.format(LN2_NUMERATOR  ))
print('    uint256 private constant LN2_DENOMINATOR = 0x{:x};'.format(LN2_DENOMINATOR))
