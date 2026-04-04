---
name: zenn-cycloud-article-writer
description: cycloud_blog向けにZenn記事を作成・推敲・公開する専用スキル。Zenn公式Markdown記法を確認し、Think IT連載の言葉遣い・語り口を参考に執筆し、Zenn CLIでプレビュー確認から公開準備まで進める。
---

# Zenn記事作成スキル

Zenn向けの技術記事を、執筆から公開準備まで一気通貫で行う。
このスキルは以下を必須要件として扱う。

- Zenn公式Markdown記法を確認して使う
- Think IT連載の言葉遣い・語り口を参考に書く
- Zenn CLIでプレビュー確認し、公開手順まで実施する
- 投稿先Publicationは `cycloud_blog` を使う

## 0. 事前確認（毎回実施）

執筆前に、以下の一次情報を確認する。

- Zenn Markdown記法一覧: https://zenn.dev/zenn/articles/markdown-guide
- Zenn CLIガイド: https://zenn.dev/zenn/articles/zenn-cli-guide
- Publication運用（`publication_name`）: https://zenn.dev/zenn/articles/how-to-use-publication
- 文体参照: https://thinkit.co.jp/corner/11870

仕様変更があり得るため、記法・CLIオプション・公開フローは一次情報を優先する。

注意:
- 上記4リンクは執筆ルール確認用であり、記事末尾の参照リンクには含めない
- 記事末尾の参照リンクには、記事テーマ・実装内容に直接関係する一次情報のみを記載する

## 1. 文体ルール（Think IT連載の語り口を参照）

Think IT連載「TypeScriptでCLIを作って学ぶAST」の書き味を参考に、以下で執筆する。

- 参照対象: 言葉遣い、語り口、説明の運び方、段落のテンポ
- 構成方針: 見出し構成は記事テーマと読者に合わせて決める（固定テンプレートの模倣はしない）
- トーン: 丁寧で落ち着いた技術解説。断定しすぎず、実務目線で説明する
- 導入: 最初に「この記事で何を扱うか」と前提条件を1-2段落で示す
- 進め方: 手順を順番に示し、各手順の意図を短く補足する
- コード説明: 先に要点、次にコード、最後に挙動・注意点を説明する
- 文長: 長文を避け、1段落1トピックで区切る
- まとめ: 学んだことと次アクションを具体化する

禁止事項:

- 過度に煽る表現、断定的な誇張、不要なキャッチコピー
- 根拠のない性能主張
- Think IT記事の見出し構成や文面の機械的ななぞり

## 2. Zenn Markdown適用ルール

Zenn公式記法を前提に、以下を優先して使う。

- 見出し: 本文は `##` から開始（`#` は使わない）
- コードブロック: 言語指定を必須化し、必要ならファイル名を付与
- 差分説明: `diff` を使って変更点を明示
- 補足: `:::message` / `:::message alert` を使い分ける
- 長文補足: `:::details` で折りたたむ
- 図解: 必要なら `mermaid` を使う
- 埋め込み: URL単独行または `@[card](URL)` を使う

最小テンプレート:

```markdown
---
title: ""
emoji: "🛠️"
type: "tech"
topics: ["", "", ""]
published: false
publication_name: "cycloud_blog"
---

## はじめに

## 前提

## 実装

## まとめ
```

## 3. Front Matterルール

必須:

- `title`
- `emoji`（1文字）
- `type`（`tech` または `idea`）
- `topics`（最大5件）
- `published`（初期は `false` 推奨）
- `publication_name: "cycloud_blog"`

補助:

- 必要に応じて `published_at` を追加（JST基準）

## 4. 執筆ワークフロー

1. テーマと読者を定義する
2. 構成（h2/h3）を作る
3. Think ITの言葉遣い・語り口を参考に本文初稿を書く
4. Zenn記法（message/details/diff/mermaid）を適用する
5. 事実確認を行い、参照URLを本文末尾にまとめる（記事内容に直接関係する資料のみ。記法・CLI・Publication運用・文体参照のガイドは載せない）

## 5. Zenn CLIワークフロー

`zenn` 管理ディレクトリで実行する。

初期化（未初期化時のみ）:

```bash
npx zenn init
```

記事ファイル作成:

```bash
npx zenn new:article --slug <slug> --title "<title>" --type tech --emoji "🛠️"
```

プレビュー:

```bash
npx zenn preview
```

公開準備:

1. 対象ファイルのFront Matterを確認
2. `published: true` に変更（必要なら `published_at` を追加）
3. `publication_name: "cycloud_blog"` があることを確認
4. GitHub連携リポジトリへコミット・プッシュ

公開確認先:

- Publication管理画面: https://zenn.dev/dashboard/publications/cycloud_blog

注意:

- Zenn CLIだけでは公開完了しない。最終反映は連携GitHubリポジトリへのプッシュで行う
- `[ci skip]` / `[skip ci]` をコミットメッセージに含めるとデプロイがスキップされる

## 6. 最終チェックリスト

- [ ] Zenn公式Markdown記法に沿っている
- [ ] `##` 始まりの見出し構造になっている
- [ ] コードブロックに言語指定がある
- [ ] Think IT連載の言葉遣い・語り口を参考にしつつ、構成は記事目的に合わせている
- [ ] Front Matterに `publication_name: "cycloud_blog"` がある
- [ ] `npx zenn preview` で崩れがない
- [ ] 公開条件（`published` / `published_at`）を意図通り設定した
- [ ] 記事末尾の参照リンクは記事内容に関連するものだけで、記法・CLI・Publication運用・文体参照ガイドを含めていない
- [ ] 公開後の確認先が `https://zenn.dev/dashboard/publications/cycloud_blog` になっている
