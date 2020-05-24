<template>
  <div>
    <div class="main-container">
      <img src="images/dishare-main-logo.png" width="400px" height="300px">
      <h2>
        Dishareへようこそ <br>
        「美味しい」を共有しましょう
      </h2>
      <p>早速、キーワードを検索して、「美味しい」を検索してみましょう</p>

      <el-input placeholder="Please input" v-model="keyword" class="input-with-select" style="width:600px;">
        <el-select v-model="select" slot="prepend" placeholder="現在位置から探す" style="width:200px;">
          <el-option label="現在位置から探す" value="1"></el-option>
          <el-option label="人気店を探す" value="2"></el-option>
        </el-select>
        <el-button @click="getShops" slot="append" icon="el-icon-search"></el-button>
      </el-input>
    </div>
    <ul class="searched-list">
      <li class="shop-card" v-for="shop in shops" :key="shop.name">
        {{ shop.name }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data(){
    return {
      keyword: '',
      select: '',
      shops: []
    }
  },
  methods: {
    getShops(){
      this.$axios.$get('/api/', {
        params: {
          keyid: "cccd05138db6e13ac16bf8e63a21cd2d",
          name: this.keyword
        }
      }).then( res => {
        console.log('成功です。')
        console.log(res)
        this.shops = res.rest
        this.$notify({
          type: 'success',
          title: '10店ヒットしました！',
          message: `${this.keyword}の検索結果`,
          position: 'bottom-left',
          duration: 2000
        })
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

.main-container {
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

.main-container:before {
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
  margin: 30px 0;
}

.searched-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  background: #eee;
}

.shop-card {
  flex-shrink: 0;
  width: 400px;
  height: 100px;
  border: 1px solid gray;
  margin: 10px 0;
}

</style>
