#! /bin/bash
python split_dataset.py

# Generate distant dataset
python scripts/distant/generate.py data/datasets/ CuratedTrec-train-train.txt data/datasets/ --dev-split 0.2 --regex
python scripts/distant/generate.py data/datasets/ WebQuestions-train-train.txt data/datasets/ --dev-split 0.2
python scripts/distant/generate.py data/datasets/ WikiMovies-train-train.txt data/datasets/ --dev-split 0.2

# Convert to SQuAD data
python scripts/convert/to_squad.py data/datasets/CuratedTrec-train-train.dstrain --out-dir data/datasets/
python scripts/convert/to_squad.py data/datasets/CuratedTrec-train-train.dsdev --out-dir data/datasets/

python scripts/convert/to_squad.py data/datasets/WebQuestions-train-train.dstrain --out-dir data/datasets/
python scripts/convert/to_squad.py data/datasets/WebQuestions-train-train.dsdev --out-dir data/datasets/

python scripts/convert/to_squad.py data/datasets/WikiMovies-train-train.dstrain --out-dir data/datasets/
python scripts/convert/to_squad.py data/datasets/WikiMovies-train-train.dsdev --out-dir data/datasets/

# Preprocessing
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split CuratedTrec-train-train.dstrain-squad-like
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WebQuestions-train-train.dstrain-squad-like
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WikiMovies-train-train.dstrain-squad-like

python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split CuratedTrec-train-train.dsdev-squad-like
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WebQuestions-train-train.dsdev-squad-like
python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split WikiMovies-train-train.dsdev-squad-like

