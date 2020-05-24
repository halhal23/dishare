<template>
  <div class="container">
      <img src="images/dishare-main-logo.png" width="400px" height="300px">
      <h2>Dishareへようこそ</h2>
      <h3>「美味しい」を共有しましょう</h3>
      <p>早速、キーワードを検索して、「美味しい」を検索してみましょう</p>
      <el-input placeholder="Please input" v-model="keyword" class="input-with-select" style="width:500px;">
        <el-button slot="append" icon="el-icon-search"></el-button>
      </el-input>
     
  </div>
</template>

<script>
export default {
  data(){
    return {
      keyword: ''
    }
  }
}
</script>

<style>
/* .container: 1; */
/* .container:before: -1; */
/* header: 2; */

.container {
  position: relative;
  z-index: 1;
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  padding: 100px 0;
  justify-content: flex-start;
  flex-direction: column;
  align-items: center;
  text-align: center;
  background-image: url(~@/static/images/top-bg-main.jpg);
  background-size: cover;
  background-position: center; 
}

.container:before {
  content: '';
  position: absolute;
  z-index: -1;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(255,255,255,0.5);
}

h2, h3, p {
  margin-top: 30px;
}

</style>
