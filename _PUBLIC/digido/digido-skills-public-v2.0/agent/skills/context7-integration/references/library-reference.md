# Libraries Quick Reference — Look Up or Not?

## Almost Never Look Up
```
os, sys, json, csv, re, math, random, datetime, pathlib,
collections, itertools, functools, typing, dataclasses,
enum, logging, argparse, unittest, io, hashlib, base64,
shutil, glob, tempfile, subprocess, threading,
http.server, urllib, socket, sqlite3, configparser
```

## Usually Don't Look Up (Unless Version-Specific Error)
```
requests, flask, pandas, numpy, pytest, click,
python-dotenv, pillow, beautifulsoup4, matplotlib
```

## Usually Look Up (Frequent API Changes)
```
openai, langchain, pydantic (v2), sqlalchemy (2.0),
fastapi, supabase, firebase-admin, stripe,
transformers, torch, tensorflow
```

## Always Look Up (First Time Use)
```
Any library you haven't used before — no exceptions.
"I think I know how it works" is not the same as knowing.
```
