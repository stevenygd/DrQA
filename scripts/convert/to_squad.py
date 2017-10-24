import os
import argparse
import json

parser = argparse.ArgumentParser()
parser.add_argument('dataset', type=str, default=None,
                    help='Distance supervised dataset to be covnerted.')
parser.add_argument('--out-dir', type=str, default='/tmp',
                    help='Outputting directory')
args = parser.parse_args()

data = []
with open(args.dataset) as f:
    cnt = 0
    for l in f:
        cnt+=1
        entry = json.loads(l)
        if 'id' in entry:
            title = "%s-%d"%(entry['id'], cnt)

        context = ""
        for i, (x,y) in enumerate(entry['offsets']):
            context += " " * (x-len(context))
            context += entry['document'][i]

        qas = [{
            'id' : title,
            'answers' : [],
            'question' : ' '.join(entry['question'])
        }]

        for (x, y) in entry['answers']:
            start_idx = entry['offsets'][x][0]
            end_idx   = entry['offsets'][y][1]
            answer_text = context[start_idx:end_idx]
            qas[0]['answers'].append({
                'answer_start' : start_idx,
                'text' : answer_text
            })

        data.append({
            "paragraphs" : [{
                "context" : context,
                "qas" : qas
            }],
            "title" : title
        })

out = {
    "data":data, "version" : "1.1"
}
dataset_basename = os.path.basename(args.dataset)
output_file = os.path.join(args.out_dir, "%s-squad-like.json" % dataset_basename)
print("Outputting to :%s"%output_file)
with open(output_file, "w") as out_f:
    json.dump(out, out_f)


