# pukiwiki

## Description

penさんの「 [PukiWiki Unicode版](https://pukiwiki.sourceforge.io/)をalpineとh2oで構成したもの」を v1.5.4 対応させただけ というフォークしてのスタートが2022年でした(当時はオリジナルが1.5.3の対応でした)。

2025年春、オリジナルがPukiwiki v1.5.4 対応していることを確認しましたが、個人的にさわりたいところや勉強したいところもありましたので、フォークしたまま「オリジナルの改良点」を取り込みつつ独自路線をいくことにしました。

## インストール

```shell
mkdir $HOME/pukiwiki
docker run -p 8080:80 -v $HOME/pukiwiki:/ext -d arqtanjp/pukiwiki:1.5.4-git
open http://localhost:8080
```

ディレクトリに既にデータがあるときは上書きしない。
