#!/usr/bin/env bash
set -euo pipefail

python - <<'PY'
from pathlib import Path
import re

romans = [
    'I','II','III','IV','V','VI','VII','VIII','IX','X',
    'XI','XII','XIII','XIV','XV','XVI','XVII','XVIII','XIX','XX'
]

count = 0
for roman in romans:
    path = Path(f'canto_{roman}.md')
    if not path.exists():
        break
    text = path.read_text(encoding='utf-8')
    stanzas = len(re.findall(r'(?m)^\*\*\d+\*\*$', text))
    if stanzas < 10:
        break
    count += 1
    print(f'{roman}:{stanzas}')

print(f'completed_cantos={count}')
PY
