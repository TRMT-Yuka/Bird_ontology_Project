# Bird_ontology_Project

本リポジトリは，鳥類の音声ファイルを入力，鳥の種類名を出力する学習モデル構築に用いるデータ構築を目的としている．鳥類の系統関係を把握することにより，正しく音声から鳥の名称を判定できなかった結果に対して，その性能を図ることが可能となる．つまり，取り違えて分類した鳥同士が系統樹において近い場合と遠い場合，後者の方が誤判定としては深刻である．本リポジトリでは，WikiDataから鳥類のページを取得し，最終的にそれらの系統樹を表すエンティティパスを取得している．以下の各ディレクトリおよびコードの解説は，作成順序に基づく．

## query.tsv 

[Wikidataクエリサービス](https://query.wikidata.org/)にアクセスし，以下のSQLを実行することで得られるtsvファイルである．

```
SELECT DISTINCT ?item ?itemLabel WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE]". }
  {
    SELECT DISTINCT ?item WHERE {
      ?item p:P171 ?statement0.
      ?statement0 (ps:P171/(wdt:P171*)) wd:Q5113.
    }
  }
}
```
上記SQLは，[ウィキデータクエリビルダー](https://query.wikidata.org/querybuilder/?uselang=ja)において，図のように入力した場合に得られるものと同じであるが，ウィキデータクエリビルダーでは結果をtsvファイルにしてダウンロードすることができない．
![image](README_img/wikidata_query_gui.png)


query.tsvは，以下のようなWikidataのエンティティページリンクである．これらは，Q5113（Bird）をより上位のtaxonに持つようなエンティティ一覧であり，スズメや燕といった鳥類の名前はもちろん，スズメ目等の鳥類の分類方法に関する記事URLが含まれる．

```
item
http://www.wikidata.org/entity/Q132731
http://www.wikidata.org/entity/Q136317
http://www.wikidata.org/entity/Q179112
http://www.wikidata.org/entity/Q182761
...(略)....
```

### 取得方法
## prog1_get_json.ipynb 
query.tsvの各行に格納されたURLの情報を取得し，jsonファイルに落とし込むプログラム．操作により得られるjsonファイルは中間生成物であるのでデータ容量の事情により既に削除済み．このプロセスにより生成されたデータはprog2_maketsv.ipynbにてさらに加工される．


## prog2_maketsv.ipynb
prog1_get_json.ipynbによりjson形式でダウンロードしてきた各エンティティページのデータを加工する．また，系統樹的な遷移を表すパスを作成してオリジナルデータに付与し，data_extract/ontology.tsvに保存する．

## data_extract/ontology.tsv
prog2_maketsv.ipynbにて生成されたtsv．各カラム名は以下の通り．

+  id：Wikidataにおけるエンティティ固有のID
+  en_name：エンティティの英語名
+  ja_name：エンティティの日本語名
+  en_aliases：英語名のその他表記
+  ja_aliases：日本語名のその他表記
+  img_urls：画像URL
+  taxon_name：エンティティが所属している階層名
+  taxon_rank：階層レベルを表現するID
+  taxon_rank_name：階層レベルの英語名称
+  taxon_rank_ja_name：階層レベルの日本語名称
+  parent_taxon：一段階上位の階層を表現するID
+  parent_taxon_name：一段階上位の階層の英語名称
+  parent_taxon_ja_name：一段階上位の階層の日本語名称
+  path：最上位階層（Q5113）から現在のIDに至るまでの順路情報

## prog3_translation.ipynb
本コードで行った作業は以下の通り．
* DeePL翻訳により空白行を補填．（API無料使用可能枠を使い切ったため断念）
* 親子関係をグラフに格納後，視覚化．（グラフデータが重すぎたため断念）
* pathの階層名のみを取得し，data_extract/path_category.txtに一覧で出力し，目視で抜漏れ確認．（成功）

## data_extract/path_category.txt
上記の通り，prog3_translation.ipynbにより生成された階層名称まで次元を挙げて俯瞰した場合のpath一覧．以下に示すようなフォーマット．

```
...(略)....
Unknown/order
Unknown/order/family
Unknown/order/family/genus
Unknown/order/family/genus/species
Unknown/order/family/genus/species/subspecies
...(略)....
```
	

