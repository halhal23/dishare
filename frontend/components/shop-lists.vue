<template>
  <el-main class="list-container">
    <div class="searched-list" > 
      <!-- <shopLists v-for="shop in shops" :key="shop.name" class="shop-card" :shopInfo="shop"/> -->
      <el-card v-for="shop in shops" :key="shop.name" class="shop-card">
        <img :src="shop.image_url.shop_image1" class="shop_image" v-if="shop.image_url.shop_image1"> 
        <img :src="shop.image_url.shop_image1" class="shop_image" v-else-if="shop.image_url.shop_image2"> 
        <img class="shop_image" src="https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png" v-else> 
        <div class="card_shop_info">
          <p class="name">{{ shop.name }}</p>
          <el-tag type="warning" size="mini">{{ shop.category }}</el-tag>
          <p class="opentime" v-if="shop.access">{{ shop.access.station }}から{{ shop.access.walk }}分</p>
          <p class="opentime" v-else>交通アクセス: 記載なし</p>
          <p class="opentime" v-if="shop.opentime">営業時間: {{ shop.opentime }}</p>
          <p class="opentime" v-else>営業時間: 記載なし</p>
          <el-button @click="showShopInfo(shop)" type="success" size="small" plain round>詳細を見る</el-button>
        </div>
      </el-card>
    </div>

    <el-dialog class="showInfoDialog" :title="shop.name" :visible.sync="dialogFormVisible">
      <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="詳細情報" name="first">

          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>営業時間</span>
          </p>
          <p class="infoContent" v-if="shop.opentime">{{ shop.opentime }}</p>
          <p class="infoContent" v-else>サイトHPにてご確認下さい</p>
                    
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
            <span v-if="shop.lunch">昼: {{ shop.lunch }}円</span> <br v-if="shop.lunch">
            <span v-if="shop.budget">夜: {{ shop.budget }}円</span> <br v-if="shop.budget">
            <span v-if="shop.party">宴会: {{ shop.party }}円</span> <br v-if="shop.party">
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
          
          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>サイトURL</span>
          </p>
          <p class="infoContent"><a :href="shop.url" target="_blank">{{ shop.url }}</a></p>
          
          <p class="infoTitle">
            <i class="el-icon-s-help"></i>
            <span>PR文</span>
          </p>
          <p class="infoContent" v-if="shop.pr">{{ shop.pr.pr_long }}</p>
          <p class="infoContent" v-else>記載なし</p>
          
        </el-tab-pane>
        <el-tab-pane label="マップ" name="second">
          <shopMap />
        </el-tab-pane>
        <el-tab-pane label="シェア" name="third">Role</el-tab-pane>
      </el-tabs>
    </el-dialog>
    <!-- <el-button type="text" @click="onModal(true)">開けゴマ</el-button> -->

    <testModal :testModal="testModal" @onModal="onModal(false)" />
  </el-main>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import shopMap from '~/components/shop-map.vue'
import testModal from '~/components/test-modal.vue'
export default {
  components: {
    shopMap,testModal
  },
  data(){
    return {
      dialogFormVisible: false,
      formLabelWidth: '120px',
      activeName: 'first',
      testModal: false,
      currentDate: new Date(),
    }
  },
  computed: {
    ...mapGetters({ shops: 'shops/shops' }),
    ...mapGetters({ shop: 'shops/shop' }),
  },
  methods: {
    showShopInfo(shop){
      this.dialogFormVisible = true
      this.setShopInfo(shop)
    },
    handleClick(tab, event) {
      // console.log(tab, event);
    },
    onModal(testModal){
      this.testModal = testModal
    },
    ...mapMutations({ setShopInfo: 'shops/setShopInfo'})
  },
  mounted(){
    console.log(this.shops)
  }
}
</script>

<style>
.list-container {
  width: 100%;
  background: rgb(153, 81, 13);
  background-image: url(~@/static/images/dishare-main-logo.png);
  background-size: 70%;
  background-repeat: no-repeat;
  background-position: center;
}
.searched-list {
  width: 100%;
}
.searched-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}

.shop-card {
  flex-shrink: 0;
  width: 500px;
  height: 200px;
  margin: 10px 0;
  padding: 0;
}
.el-card__body {
  padding: 0;
  height: 100%;
  display: flex;
}
.shop-card .shop_image{
  width: 200px;
  height: 100%;
}

.card_shop_info {
  overflow: hidden;
  white-space: nowrap;
  padding: 10px 10px 10px 20px;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: space-between;
}
.card_shop_info p {
  width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
}
.card_shop_info p.opentime {
  font-size: 14px;
  color: #999;
}
.card_shop_info p.name {
  font-weight: bold;
  line-height: 30px;
}

.el-dialog {
  height: 600px;
  width: 600px;
}
.el-dialog__body {
  padding: 0 20px;
}
.el-tabs__content {
  height: 450px;
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

@media (min-width: 0px) and (max-width: 600px) {
  .el-dialog {
    width: 100%;
  }
  .shop-card {
    width: 100%;
    height: 450px;
  }
  .el-card__body {
    flex-direction: column;
  }
  .shop-card .shop_image {
    width: 100%;
    height: 300px;
  }
}
</style>