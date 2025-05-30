let express=require("express"); // was
let bodyParser=require("body-parser"); // form에 입력한 데이터처리
let mysql=require("mysql"); // mysql driver
let cors=require("cors"); // cors 모듈

//데이터베이스연결
let conn=mysql.createConnection({
    user:"jwbook",
    password:"1234",
    database:"jwbookdb"
});
//웹서버생성. 
let app=express();
//웹서버옵션설정
app.use(express.static("public")); //public폴더 인식. 사용가능하도록.
app.use(bodyParser.json()); // 전달받은 데이터 json으로 변환
app.use(bodyParser.urlencoded({extended:false})); // urlencode설정
let corsOption={
    //접속을 허용할 프론트엔드 주소 명시
    origin:"http://localhost:3000", // React서버에서 요청시 허용
    credential:true // 설정내용 header에 추가
};
app.use(cors(corsOption)); // cors미들웨어. 주소가 다른 FE의 AJAX요청 허용
//웹서버스타트
app.listen(52273,function(){
    console.log("서버가 시작되었습니다. http://127.0.0.1:52273");
});

/* 라우팅(Routing). 주소를 생성해서 처리. ******************/

//목록
app.get("/list",function(request,response){
    conn.query("select * from todolist order by id desc",function(error,data){
        console.log("################list###############");
        console.log(data); //콘솔에 출력
        response.send(data); // FE(브라우저)로 전송
    });
});
//검색
app.get("/list/:keyword",function(request,response){
    let keyword="%"+request.params.keyword+"%";
    conn.query("select * from todolist where content like ? order by id desc",
    [keyword],
    function(error,data){
        console.log("################검색###############");
        console.log(data); //콘솔에 출력
        response.send(data); // FE(브라우저)로 전송
    });
});


//등록
app.post("/regist",function(request,response){
    conn.query("insert into todolist(content,isDone,createdDate) values(?,?,?)",
    [request.body.content,false,new Date()],
    function(error,data){
        console.log("###########insert##############");
        console.log(data);
        response.send(data); // FE(브라우저)로 전송
    })
});
//삭제
app.delete("/remove/:id",function(request,response){
    conn.query("delete from todolist where id=?",
    [request.params.id],
    function(error,data){
        console.log("###########delete##############");
        console.log(data);
        response.send(data); // FE(브라우저)로 전송
    });
});
//content수정
app.put("/modify/:id",function(request,response){
    conn.query("update todolist set content=? where id=?",
    [request.body.content,request.params.id],
    function(error,data){
        console.log("###########update##############");
        console.log(data);
        response.send(data); // FE(브라우저)로 전송
    });
});
//isDone수정
app.put("/modify/isDone/:id",function(request,response){
    conn.query("update todolist set isDone=? where id=?",
    [request.body.isDone,request.params.id],
    function(error,data){
        console.log("###########isDone update##############");
        console.log(data);
        response.send(data); // FE(브라우저)로 전송
    });
});