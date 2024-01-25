#!/bin/bash

start_date="2024-01-25"
end_date="2024-03-18"

function daterange() {
    local d1=$(date -d "$1" +%s)
    local d2=$(date -d "$2" +%s)
    echo $(( (d2 - d1) / 86400 ))
}

total_days=$(daterange "$start_date" "$end_date")

for ((i=0; i<=total_days; i++)); do
    commit_date=$(date -d "$start_date +$i days" "+%Y-%m-%d")
    commits=$((1 + RANDOM % 3))  # 1 to 3 commits per day

    for ((j=1; j<=commits; j++)); do
        echo "$commit_date Commit $j" >> activity.log
        git add activity.log
        GIT_AUTHOR_DATE="$commit_date 10:00:00" \
        GIT_COMMITTER_DATE="$commit_date 10:00:00" \
        git commit -m "Fake commit $j on $commit_date"
    done
done
