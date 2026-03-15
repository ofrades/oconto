#!/usr/bin/env bash
set -euo pipefail

python - <<'PY'
from pathlib import Path
import re

tracker = Path('autoresearch.realigned.txt')
entries = []
if tracker.exists():
    seen = set()
    for raw in tracker.read_text(encoding='utf-8').splitlines():
        item = raw.strip()
        if not item or item.startswith('#') or item in seen:
            continue
        seen.add(item)
        entries.append(item)

count = 0
for item in entries:
    path = Path(item)
    if not path.exists():
        continue
    text = path.read_text(encoding='utf-8')
    stanzas = len(re.findall(r'(?m)^\*\*\d+\*\*$', text))
    if stanzas < 10:
        continue
    count += 1
    print(f'{item}:{stanzas}')

print(f'realigned_cantos={count}')
PY
