// 参考: json-serverの実装に関する参考資料
// https://blog.eleven-labs.com/en/json-server

// Mock用のJSONレスポンスサーバーの初期化設定
const jsonServer = require('json-server');
const server = jsonServer.create();

// Database構築用のJSONファイル
const router = jsonServer.router('datasources/db.json');

// 各種設定用
const middlewares = jsonServer.defaults();
const rewrite_rules = jsonServer.rewriter({
    "/api/v1.0/articles/list?page=:page" : "/get_articles_list/?page=:page",
    "/api/v1.0/articles/detail?id=:id"   : "/get_article_by_id/:id",
    "/api/v1.0/articles/sliders"         : "/get_sliders_list",
    "/api/v1.0/articles/recommend"       : "/get_recommend_list",
});

// リクエストのルールを設定する
server.use(rewrite_rules);

// ミドルウェアを設定する (※コンソール出力するロガーやキャッシュの設定等)
server.use(middlewares);

// 受信したリクエストにおいてGET送信時のみ許可する
server.use(function (req, res, next) {
    if (req.method === 'GET') {
        next();
    }
});

// ルーティングを設定する
server.use(router);

// サーバをポート3000で起動する
server.listen(3000, () => {
    console.log('Chapter02 Mock Server is running...');
});
