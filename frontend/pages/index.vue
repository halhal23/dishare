<template>
  <div>
    <div class="main-container">
      <img src="images/dishare-main-logo.png" width="400px" height="300px">
      <h2>
        Dishareへようこそ <br>
        「美味しい」を共有しましょう {{ name }}
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
    <shopLists /> <!-- 検索結果一覧を表示するコンポーネント -->
  </div>
</template>

<script>
import shopLists from '~/components/shop-lists.vue'
import { mapGetters, mapMutations } from 'vuex'
export default {
  components: {
    shopLists
  },
  data(){
    return {
      keyword: '',
      select: '',
      dialogShopDetailVisible: false,
      detailName: 'no name',
    }
  },
  computed: {
    ...mapGetters({
      name: 'shops/name',
      shops: 'shops/shops'
      })
  },
  methods: {
    getShops(){
      console.log(this)
      this.$axios.$get('/api/', {
        params: {
          keyid: process.env.gnavi_api_key,
          name: this.keyword
        }
      }).then( res => {
        console.log('成功です。')
        console.log(res)
        this.setShops(res.rest)
        this.$notify({
          type: 'success',
          title: `${res.rest.length}店ヒットしました！`,
          message: `${this.keyword}の検索結果`,
          position: 'bottom-left',
          duration: 2000
        })
      }).catch( err => {
        console.log('失敗です。')
        console.log(err)
      })
    },
    showShopDetail(name){
      this.dialogShopDetailVisible = true
      this.detailName = name
      console.log('alert ' + name)
    },
    ...mapMutations({ setShops: 'shops/setShops'})
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



</style>
