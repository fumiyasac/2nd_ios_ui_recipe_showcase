// 参考: json-serverに関するもの
// https://blog.eleven-labs.com/en/json-server

// Mock用のJSONレスポンスサーバーの初期化設定
const jsonServer = require('json-server');
const server = jsonServer.create();

// サーバをポート3000で起動する
server.listen(3000, () => {
    console.log('Chapter02 Mock Server is running...');
});
