<template>
    <div class="search_category_form">
      <el-autocomplete
        v-model="searchKeyword"
        :fetch-suggestions="querySearchAsync"
        placeholder="Please input"
      ></el-autocomplete>
      <el-button @click="searchShop" icon="el-icon-search" style="padding: 10px;display: block;flex-shrink: 0;" round></el-button>
    </div>
</template>
<script>
import { mapGetters, mapMutations } from 'vuex'
export default {
  props: ["category"],
  data() {
    return {
      options: [],
      value: [],
      list: [],
      loading: false,
      searchKeyword: '',
      timeout:  null,
      states: [
            '北海道',
            '青森県',
            '岩手県',
            '宮城県',
            '秋田県',
            '山形県',
            '福島県',
            '茨城県',
            '栃木県',
            '群馬県',
            '埼玉県',
            '千葉県',
            '東京都',
            '神奈川県',
            '新潟県',
            '富山県',
            '石川県',
            '福井県',
            '山梨県',
            '長野県',
            '岐阜県',
            '静岡県',
            '愛知県',
            '三重県',
            '滋賀県',
            '京都府',
            '大阪府',
            '兵庫県',
            '奈良県',
            '和歌山県',
            '鳥取県',
            '島根県',
            '岡山県',
            '広島県',
            '山口県',
            '徳島県',
            '香川県',
            '愛媛県',
            '高知県',
            '福岡県',
            '佐賀県',
            '長崎県',
            '熊本県',
            '大分県',
            '宮崎県',
            '鹿児島県',
            '沖縄県'
      ]
    }
  },
  methods: {
    remoteMethod(query) {
      console.log(query)
      this.value = query
      if (query !== '') {
        this.loading = true;
        setTimeout(() => {
          this.loading = false;
          this.options = this.list.filter(item => {
            return item.label.toLowerCase()
              .indexOf(query.toLowerCase()) > -1;
          });
        }, 200);
      } else {
        this.options = [];
      }
    },
    selectFocus(){
      this.options = [...this.list];
    },
    searchShop(){
      console.log(this.value)
      this.$axios.$get('/api/', {
        params: {
          keyid: process.env.gnavi_api_key,
          address: `${this.value}`,
          freeword: this.$props.category,
        }
      }).then( res => {
        this.setShops(res.rest)
        this.$notify({
          type: 'success',
          title: `${res.rest.length}店ヒットしました！`,
          message: `検索結果`,
          position: 'bottom-left',
          duration: 3000
        })
      }).catch( err => {
        console.log(err)
      })
    },
    querySearchAsync(queryString, cb) {
      var states = this.states;
      var results = queryString ? states.filter(this.createFilter(queryString)) : states;
      clearTimeout(this.timeout);
      this.timeout = setTimeout(() => {
        cb(results);
      }, 200);
    },
    createFilter(queryString) {
      return (name) => {
        return (name.value.toLowerCase().indexOf(queryString.toLowerCase()) !== -1);
      };
    },
    ...mapMutations({ 
      setShops: 'shops/setShops',
      setCurrentPosition: 'shops/setCurrentPosition',
    })
  },
  async mounted() {
    const states = this.states
    const objNames = states.map( v => {
      return { value: v }
    })
    this.states = objNames;
  },
}
</script>
<style>
.search_category_form {
  border: 1px solid #fff;
  width: 70%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-radius: 20px;
  background: #555;
}
.search_category_form .el-input__inner{
  background: transparent;
  border: transparent;
  width: 100%;
  color: #fff;
}
</style>