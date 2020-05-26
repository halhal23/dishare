<template>
  <div class="list-container">
    <div class="searched-list"> 
      <!-- <shopLists v-for="shop in shops" :key="shop.name" class="shop-card" :shopInfo="shop"/> -->
      <div @click="showShopInfo(shop)" v-for="shop in shops" :key="shop.name" class="shop-card">{{ shop.name }}</div>
    </div>

    <el-dialog class="showInfoDialog" :title="shop.name" :visible.sync="dialogFormVisible">
      <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="詳細情報" name="first">

          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>営業時間</span>
          </p>
          <p class="infoContent">{{ shop.opentime }}</p>
                    
          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>交通アクセス</span>
          </p>
          <p class="infoContent" v-if="shop.access">{{ shop.access.line }}{{ shop.access.station }}から徒歩{{ shop.access.walk }}分</p>

          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>予算</span>
          </p>
          <p class="infoContent">
            昼: {{ shop.lunch }}円 <br>
            夜: {{ shop.budget }}円 <br>
            宴会: {{ shop.party }}円 <br>
          </p>
          
          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>休業日</span>
          </p>
          <p class="infoContent">{{ shop.holiday }}</p>
          
          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>クレジットカード</span>
          </p>
          <p class="infoContent">{{ shop.credit_card }}</p>
          
          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>所在地</span>
          </p>
          <p class="infoContent">{{ shop.address }}</p>
          
          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>電話番号</span>
          </p>
          <p class="infoContent">{{ shop.tel }}</p>
          
        </el-tab-pane>
        <el-tab-pane label="マップ" name="second">Config</el-tab-pane>
        <el-tab-pane label="シェア" name="third">Role</el-tab-pane>
      </el-tabs>
    </el-dialog>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
export default {
  data(){
    return {
      dialogFormVisible: false,
      formLabelWidth: '120px',
      activeName: 'first'
    }
  },
  computed: {
    ...mapGetters({ shops: 'shops/shops' }),
    ...mapGetters({ shop: 'shops/shop' })
  },
  methods: {
    showShopInfo(shop){
      this.dialogFormVisible = true
      this.setShopInfo(shop)
    },
    handleClick(tab, event) {
      // console.log(tab, event);
    },
    ...mapMutations({ setShopInfo: 'shops/setShopInfo' })
  }
}
</script>



<style>
.list-container {
  width: 100%;
}
div.searched-list {
  width: 100%;
  /* border: 1px solid gray;
  width : 400px;
  height: 150px;
  margin: 10px 0;
  flex-shrink: 0; */
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

.el-dialog {
  height: 600px;
}
.el-tabs__content {
  height: 400px;
  overflow-y: scroll;
}
.infoTitle {
  border-bottom: 1px solid #ccc;
  margin: 10px 0;
}
.infoTitle span {
  font-weight: bold;
}
.infoContent {
  margin: 10px 0;
}
</style>