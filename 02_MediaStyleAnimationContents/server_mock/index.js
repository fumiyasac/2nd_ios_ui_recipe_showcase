// 参考: json-serverに関するもの
// https://blog.eleven-labs.com/en/json-server

// Mock用のJSONレスポンスサーバーの初期化設定
const jsonServer = require('json-server');
const server = jsonServer.create();

// Database構築用のJSONファイル
const router = jsonServer.router('datasource/db.json');

// 各種設定用
const middlewares = jsonServer.defaults();
const rewrite_rules = jsonServer.rewriter({
    "/api/v1.0/articles/list?page=:page" : "/get_articles_list/?page=:page",
    "/api/v1.0/articles/detail?id=:id"   : "/get_article_by_id/:id",
    "/api/v1.0/articles/sliders"         : "/get_sliders_list",
    "/api/v1.0/articles/recommend"       : "/get_recommend_list",
});

// サーバをポート3000で起動する
server.listen(3000, () => {
    console.log('Chapter02 Mock Server is running...');
});
