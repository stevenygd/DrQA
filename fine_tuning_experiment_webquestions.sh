#! /bin/bash

for i in "50" "55" "60"; do
    path="models/my_finetune_webquestions_epo$i"
    if [ ! -d "$path" ]; then
        echo "Path not exists : $path"
        mkdir -p $path/
        echo "Make path $path"
        python scripts/reader/train.py \
            --num-epochs=$i \
            --batch-size=32 \
            --model-dir $path/ \
            --model-name MyFinetuneWebQuestions \
            --data-dir data/datasets/ \
            --train-file WebQuestions-train.dstrain-squad-like-processed-corenlp.txt \
            --dev-file WebQuestions-train.dsdev-squad-like-processed-corenlp.txt \
            --dev-json WebQuestions-train.dsdev-squad-like.json \
            --embedding-file glove.840B.300d.txt \
            --checkpoint True \
            --pretrained data/reader/single.mdl \
            --embedding-file glove.840B.300d.txt \
            --expand-dictionary True \
            --use-ner=False \
            --use-pos=False \
            --use-lemma=False \
            --tune-partial 1000;

        python scripts/pipeline/predict.py data/datasets/WebQuestions-test.txt \
            --reader-model $path/MyFinetuneWebQuestions.mdl \
            --out-dir $path/ \
            --candidate-file data/datasets/freebase-entities.txt;
    fi;

    python scripts/pipeline/eval.py data/datasets/WebQuestions-test.txt $path/WebQuestions-test-MyFinetuneWebQuestions-pipeline.preds > $path/webquestion-result-epo$i.log
    cat $path/webquestion-result-epo$i.log

done
