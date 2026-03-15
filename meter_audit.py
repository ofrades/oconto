#!/usr/bin/env python3
from pathlib import Path
import re
import sys

VOWELS = 'aeiouáéíóúâêôãõüà'


def syllable_groups(word: str) -> int:
    groups = re.findall(r'[aeiouáéíóúâêôãõüà]+', word.lower())
    return len(groups) if groups else 1


def rough_count(line: str) -> int:
    words = re.findall(r"[A-Za-zÀ-ÿ']+", line)
    return sum(syllable_groups(w) for w in words)


def main(path_str: str):
    path = Path(path_str)
    text = path.read_text(encoding='utf-8').splitlines()
    for i, line in enumerate(text, 1):
        s = line.strip()
        if not s or s.startswith('#') or s.startswith('**'):
            continue
        c = rough_count(s)
        flag = 'OK'
        if c < 9 or c > 13:
            flag = 'CHECK'
        print(f'{i:>4}  {c:>2}  {flag}  {s}')


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('usage: meter_audit.py <canto.md>')
        raise SystemExit(1)
    main(sys.argv[1])
