<template>
  <el-main class="top_main" style="padding: 0;">
    <el-row class="top_contents" style="height: 100vh;">
      <el-col :span="11" class="left main"></el-col>
      <el-col :span="13" class="right main">
        <p style="color: #777;">Our concept</p>

        <div class="concept">
          <p>
            <span>DISHARE</span><br>
            <span>THAT</span><br>
            <span>SHARE</span><br>
            <span>DELICIOUS</span>
          </p>
        </div>

        <shopSearchForm /> <!-- レストラン検索フォームのコンポーネント -->

        <p style="font-family: cursive;font-size: 30px;">
          First, enter the keyword, <br>
          Let's search for a restaurant.
        </p>
      </el-col>
    </el-row>
    <shopLists /> <!-- 検索結果一覧を表示するコンポーネント -->
  </el-main>
</template>

<script>
import shopLists from '~/components/shop-lists.vue'
import shopSearchForm from '~/components/shop-search-form.vue'
export default {
  components: {
    shopLists,shopSearchForm
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
  padding: 70px 30px 10px ;
  flex-direction: column;
  justify-content: space-around;
}
.concept p {
  line-height: 0.9;
  font-size: 7.6vw;
  font-weight: 400;
  font-family: "Maison Cacao", serif;
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
}
</style>