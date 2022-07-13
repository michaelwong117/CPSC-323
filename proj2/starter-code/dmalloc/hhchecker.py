import re

pattern_v = """
    \s* HEAVY \s* HITTER \s* :?
    \s* (\w+\.cc) \s* :? \s* (\d+) \s* :?
     \s* (\d+) \s* (?:bytes)?
     [\s~\(\)%]* (\d+ (?: \. \d*)?) [\s~\(\)%]*
"""
hh_pattern = re.compile(pattern_v, flags=re.VERBOSE | re.I)


m = hh_pattern.match("HEAVY HITTER: hhtest.cc:49: 1647247360 bytes (~50.1%)")
if m is None:
    print("line mismatch")
else:
    print("line match")