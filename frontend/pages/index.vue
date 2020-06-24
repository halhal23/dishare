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

        <p class="promptMsg">
          First, enter the keyword, <br>
          Let's search for a restaurant.
        </p>
      </el-col>
    </el-row>
    <shopLists />  <!-- 検索結果一覧を表示するコンポーネント -->
    <div class="slideshow">
      <p style="font-size: 28px;color: #eee;font-weight: bold;margin: 20px 0 70px;">Search by category</p>
      <el-carousel :autoplay="false" type="card" height="400px">

        <el-carousel-item class="italian">
          <div style="height: 100%;width: 100%;background: rgba(0,0,0,0.3);padding: 30px;">
            <p class="category_title" style="">ITALIAN</p>
            <shopCategorySearch category="イタリアン" class="category_form"/>
          </div>
        </el-carousel-item>
        <el-carousel-item class="chinese">
          <div style="height: 100%;width: 100%;background: rgba(0,0,0,0.3);padding: 30px;">
            <p class="category_title" style="">CHINESE</p>
            <shopCategorySearch category="中華" class="category_form"/>
          </div>
        </el-carousel-item>
        <el-carousel-item class="japanese">
          <div style="height: 100%;width: 100%;background: rgba(0,0,0,0.3);padding: 30px;">
            <p class="category_title" style="">JAPANESE</p>
            <shopCategorySearch category="和食" class="category_form"/>
          </div>
        </el-carousel-item>
        <el-carousel-item class="french">
          <div style="height: 100%;width: 100%;background: rgba(0,0,0,0.3);padding: 30px;">
            <p class="category_title" style="">FRENCH</p>
            <shopCategorySearch category="フランス" class="category_form"/>
          </div>
        </el-carousel-item>

      </el-carousel>
    </div>
  </el-main>
</template>

<script>
import shopLists from '~/components/shop-lists.vue'
import shopSearchForm from '~/components/shop-search-form.vue'
import shopCategorySearch from '~/components/shop-category-search.vue'
export default {
  components: {
    shopLists,shopSearchForm, shopCategorySearch
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
  padding: 60px 30px 10px ;
  flex-direction: column;
  justify-content: space-around;
}
.concept p {
  line-height: 0.9;
  font-size: 7.6vw;
  font-weight: 400;
  font-family: "Maison Cacao", serif;
}
.promptMsg {
  font-family: Times, 'Times New Roman', serif;
  font-size: 24px;
}
.slideshow {
  height: 700px;
  padding: 50px 20px;
  background: #555;
  text-align: center;
}
.slideshow .el-carousel__indicators  {
  margin-top: 20px;
}
.slideshow .el-carousel__item.italian {
  background-image: url('/images/italian.png');
  background-size: cover;
  background-position: center;
}
.slideshow .el-carousel__item.chinese {
  background-image: url('/images/chinese.png');
  background-size: cover;
  background-position: center;
}
.slideshow .el-carousel__item.japanese {
  background-image: url('/images/japanese.png');
  background-size: cover;
  background-position: center;
}
.slideshow .el-carousel__item.french {
  background-image: url('/images/french.png');
  background-size: cover;
  background-position: center;
}

.slideshow .el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.slideshow .el-carousel__item:nth-child(2n+1) {
  background-color: #555;
}
.category_title {
  font-size: 50px;
  font-weight: bold;
  color: #eee;
  text-align: center;
  margin-bottom: 80px
}
.category_form {
  margin: 0 auto;
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
  .promptMsg {
    font-size: 14px;
  }
  .slideshow {
    padding: 50px 0;
  }
  .slideshow .el-carousel__item {
    width: 100%;
  }
  .category_title {
    text-align: left;
  }
  .category_form {
    margin: 0;
  }
}
</style>