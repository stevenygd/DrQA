#! /bin/bash

# Generate distant dataset
python scripts/distant/generate.py data/datasets/ CuratedTrec-train.txt data/datasets/ --dev-split 0.2 --regex
python scripts/distant/generate.py data/datasets/ WebQuestions-train.txt data/datasets/ --dev-split 0.2
python scripts/distant/generate.py data/datasets/ WikiMovies-train.txt data/datasets/ --dev-split 0.2

# Convert to SQuAD data
python scripts/convert/to_squad.py data/datasets/CuratedTrec-train.dstrain --out-dir data/datasets/
python scripts/convert/to_squad.py data/datasets/CuratedTrec-train.dsdev --out-dir data/datasets/

python scripts/convert/to_squad.py data/datasets/WebQuestions-train.dstrain --out-dir data/datasets/
python scripts/convert/to_squad.py data/datasets/WebQuestions-train.dsdev --out-dir data/datasets/

python scripts/convert/to_squad.py data/datasets/WikiMovies-train.dstrain --out-dir data/datasets/
python scripts/convert/to_squad.py data/datasets/WikiMovies-train.dsdev --out-dir data/datasets/

# Preprocessing
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split CuratedTrec-train.dstrain-squad-like
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WebQuestions-train.dstrain-squad-like
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WikiMovies-train.dstrain-squad-like

python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split CuratedTrec-train.dsdev-squad-like
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WebQuestions-train.dsdev-squad-like
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WikiMovies-train.dsdev-squad-like
