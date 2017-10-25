#! /bin/bash

# python combine_squad.py

# python scripts/reader/preprocess.py data/datasets/ data/datasets/ --split DistDataAll-train

# python scripts/reader/train.py \
#     --num-epochs=60 \
#     --batch-size=32 \
#     --model-dir models/ \
#     --model-name MyMultitask \
#     --data-dir data/datasets/ \
#     --train-file DistDataAll-train-processed-corenlp.txt \
#     --dev-file CuratedTrec-train.dsdev-squad-like-processed-corenlp.txt \
#     --dev-json CuratedTrec-train.dsdev-squad-like.json \
#     --embedding-file glove.840B.300d.txt \
#     --tune-partial 1000 \
#     --checkpoint True

python scripts/pipeline/predict.py data/datasets/CuratedTrec-test-sm.txt --out-dir `pwd` --reader-model models/MyMultitask.mdl --batch-size=64 --predict-batch-size=64

python scripts/pipeline/predict.py data/datasets/WikiMovies-test-sm.txt --out-dir `pwd` --reader-model models/MyMultitask.mdl --batch-size=64 --predict-batch-size=64

python scripts/pipeline/predict.py data/datasets/WebQuestions-test-sm.txt --out-dir `pwd` --reader-model models/MyMultitask.mdl --batch-size=64 --predict-batch-size=64

python scripts/pipeline/predict.py data/datasets/SQuAD-v1.1-dev-sm.txt --out-dir `pwd` --reader-model models/MyMultitask.mdl --batch-size=64 --predict-batch-size=64

python scripts/pipeline/eval.py data/datasets/CuratedTrec-test-sm.txt CuratedTrec-test-sm-MyMultitask-pipeline.preds --regex

python scripts/pipeline/eval.py data/datasets/WikiMovies-test-sm.txt WikiMovies-test-sm-MyMultitask-pipeline.preds

python scripts/pipeline/eval.py data/datasets/WebQuestions-test-sm.txt WebQuestions-test-sm-MyMultitask-pipeline.preds

python scripts/pipeline/eval.py data/datasets/SQuAD-v1.1-dev-sm.txt SQuAD-v1.1-dev-sm-MyMultitask-pipeline.preds

