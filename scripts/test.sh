#!/bin/bash

table=$1
tmp_sql=$(mktemp)

echo "Diff table: $table"

dbdiff \
  --type=all \
  --nocomments=true \
  --server1=root:secret@mysql1:3306 \
  --server2=root:secret@mysql2:3306 \
  --output=$tmp_sql \
  "server1.mysql1.$table:server2.mysql2.$table"

cat $tmp_sql
