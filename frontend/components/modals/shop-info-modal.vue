<template>
    <el-dialog class="showInfoDialog" :title="shop.name" :visible.sync="$props.shopInfoModalVisible" :before-close="handleClose">
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
        <el-tab-pane label="シェア" name="third">
          <div @click="test">sfsdfsfsdfsdfsdf</div>
          <el-form>
            <el-form-item label="content" :label-width="formLabelWidth">
              <el-input type="textarea" v-model="form.content" ></el-input>
            </el-form-item>
              <el-button @click="postsCreate">create</el-button>
          </el-form>
        </el-tab-pane>
      </el-tabs>
    </el-dialog>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import shopMap from '~/components/shop-map.vue'
export default {
  data(){
    return {
      activeName: 'first',
      formLabelWidth: '120px',
      form: {
        title: '',
        content: '',
        shop_name: '',
        shop_address: '',
        shop_access: '',
        shop_url: '',
        shop_image: '',
        user_id: '',
      }
    }
  },
  props: {
    shopInfoModalVisible: Boolean,
  },
  computed: {
    ...mapGetters({ shop: 'shops/shop' }),
  },
  methods: {
    postsCreate(){
      let formData = {
        title: this.form.title,
        content: this.form.content,
        shop_name: this.shop.name,
        shop_category: this.shop.category,
        shop_address: this.shop.address,
        shop_access: `${this.shop.access.line}${this.shop.access.station}から徒歩${this.shop.access.walk}分`,
        shop_url: this.shop.url,
        shop_image_url: this.shop.image_url.shop_image1,
        user_id: this.$store.state.auth.currentUser.id,
      }
      console.log(formData)
      this.$axios.$post(process.env.browserBaseUrl + '/api/posts', formData).then(res => {
        console.log('create post 成功')
        console.log(res)
      }).catch(err => {
        console.log(err)
      })
    },
    handleClose() {
      this.$emit('onModal')
    },
    handleClick(tab, event) {
      // console.log(tab, event);
    },
    test(){
      console.log(this.shop)
    }
  },
  components: {
    shopMap
  },
}
</script>

<style>
.el-dialog {
  /* height: 600px; */
  width: 600px;
}
.el-dialog__body {
  padding: 10px 20px;
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
}
</style>