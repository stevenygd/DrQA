#! /bin/bash

path="models/single_pipeline$i"
rm -r $path/
mkdir -p $path/
echo "Make $path"

echo "Predictin curated trects..."
python scripts/pipeline/predict.py data/datasets/CuratedTrec-test.txt \
    --reader-model data/reader/single.mdl \
    --out-dir $path/;
python scripts/pipeline/eval.py data/datasets/CuratedTrec-test.txt \
    $path/CuratedTrec-test-single-pipeline.preds --regex > $path/curated-test-result-epo$i.log
cat $path/curated-test-result-epo$i.log

echo "Predicting web questions..."
python scripts/pipeline/predict.py data/datasets/WebQuestions-test.txt \
    --reader-model data/reader/single.mdl \
    --candidate-file data/datasets/freebase-entities.txt \
    --out-dir $path/;
python scripts/pipeline/eval.py data/datasets/WebQuestions-test.txt \
    $path/WebQuestions-test-single-pipeline.preds --regex > $path/webquestions-test-result-epo$i.log
cat $path/webquestions-test-result-epo$i.log

echo "Predicting WikiMovies..."
python scripts/pipeline/predict.py data/datasets/WikiMovies-test.txt \
    --reader-model data/reader/single.mdl \
    --candidate-file data/datasets/WikiMovies-entities.txt \
    --out-dir $path/;
python scripts/pipeline/eval.py data/datasets/WikiMovies-test.txt \
    $path/WikiMovies-test-single-pipeline.preds > $path/wikimovies-test-result-epo$i.log
cat $path/wikimovies-test-result-epo$i.log
