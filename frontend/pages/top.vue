<template>
  <el-main class="top_main" style="padding: 0;">
    <el-row class="top_contents" style="height: 100vh;">
      <el-col :span="11" class="left main">left</el-col>
      <el-col :span="13" class="right main">
        <p style="color: #777;">Welcome</p>
        <div class="concept">
          <p>
            <span>DISHARE</span><br>
            <span>THAT</span><br>
            <span>SHARE</span><br>
            <span>DELICIOUS</span>
          </p>
        </div>

        <el-row class="searchInput" style="background: rgba(255,255,255,0);">
          <el-col :span="24" :lg="12">
            <el-input placeholder="検索キーワード" v-model="keyword"></el-input>
          </el-col>
          <el-col :span="16" :lg="8">
            <el-select v-model="select" placeholder="指定せず検索" class="select" style="width: 100%;background: #F5F7FA;">
              <el-option label="近くの店を探す" value="1"></el-option>
              <el-option label="人気店を探す" value="2"></el-option>
              <el-option label="指定せず検索" value="3"></el-option>
            </el-select>
          </el-col>
          <el-col :span="8" :lg="4">
            <el-button @click="do_either_search" icon="el-icon-search" style="width: 100%;"></el-button>
          </el-col>
        </el-row>
        <p style="font-family: dnp-shuei-gothic-gin-std;">
          まずはキーワードを入力して、<br>
          レストランを検索してみましょう。
        </p>
      </el-col>
    </el-row>
  </el-main>
</template>

<script>
export default {
  data(){
    return {
      keyword: '',
      select: ''
    }
  },
  methods: {
    do_either_search(){
      switch (this.select) {
        case '1':
          console.log(1111)
          break
        case '2':
          console.log(222222)
          break
        case '3', '':
          console.log(333333)
          break
        default:
          console.log('defaul');
          break
      }
    }
  }
}
// #F5F7FA
</script>
<style>
.el-row.top_contents {
  background: #fff;
}
.el-row.top_contents .el-col.main {
  /* border: 1px solid black; */
  height: 100%;
}
.el-row.top_contents .el-col.left {
  /* border: 1px solid black; */
  height: 100%;
  background-image: url(~@/static/images/top-left-dish.jpg);
  background-size: cover;
  background-position: center; 
}
.el-row.top_contents .el-col.right {
  background: rgb(229, 226, 221);
  display: flex;
  padding: 70px 30px;
  flex-direction: column;
  justify-content: space-around;
}
.el-row.searchInput {
  width: 600px;
}

button.el-button,
.select .el-input__inner {
  background: #F5F7FA;
}

.concept p {
  line-height: 0.9;
  font-size: 7.6vw;
  font-weight: 400;
  font-family: "Maison Cacao", serif;
}

@media (min-width: 769px) and (max-width: 1200px) {
  .el-row.searchInput {
    width: 100%;
  }
}
@media (min-width: 0px) and (max-width: 768px) {
  .el-row.top_contents {
    display: flex;
    flex-direction: column-reverse;
  }
  .el-row.top_contents .el-col.main {
    width: 100%;
    text-align: center;
  }
  .el-row.searchInput {
    width: 100%;
  }
}
</style>