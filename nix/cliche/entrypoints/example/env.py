#!/usr/bin/env python3

from cliche import cli
import os


@cli
def env():
    a = os.environ["test"]
    print(a)
