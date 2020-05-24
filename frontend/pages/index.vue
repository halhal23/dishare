<template>
  <div class="container">
      <img src="images/dishare-main-logo.png" width="400px" height="300px">
      <h2>Dishareへようこそ</h2>
      <h3>「美味しい」を共有しましょう</h3>
      <p>早速、キーワードを検索して、「美味しい」を検索してみましょう</p>
      <el-input placeholder="Please input" v-model="keyword" class="input-with-select" style="width:500px;">
        <el-button @click="getShops" slot="append" icon="el-icon-search"></el-button>
      </el-input>
     
  </div>
</template>

<script>
export default {
  data(){
    return {
      keyword: ''
    }
  },
  methods: {
    getShops(){
      this.$axios.$get('/api/', {
        params: {
          keyid: "cccd05138db6e13ac16bf8e63a21cd2d",
          name: "肉"
        }
      }).then( res => {
        console.log('成功です。')
        console.log(res)
        this.shops = res.rest
      }).catch( err => {
        console.log('失敗です。')
        console.log(err)
      })
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
  background: rgba(255,255,255,0.7);
}

h2, h3, p {
  margin-top: 30px;
}

</style>
