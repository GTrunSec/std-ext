#!/usr/bin/env python3
from cliche import cli


@cli
def add(a: int, b: int):
    print(a + b)
