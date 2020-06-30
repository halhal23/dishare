<template>
  <el-main style="padding: 100px;">
    <el-autocomplete
      v-model="searchKeyword"
      :fetch-suggestions="querySearchAsync"
      placeholder="Please input"
    >
      <el-button slot="append" icon="el-icon-search"></el-button>
    </el-autocomplete>
  </el-main>
</template>
<script>
  export default {
    data() {
      return {
        userNames: [],
        searchKeyword: '',
        timeout:  null
      };
    },
    methods: {
      querySearchAsync(queryString, cb) {
        var userNames = this.userNames;
        var results = queryString ? userNames.filter(this.createFilter(queryString)) : userNames;
        clearTimeout(this.timeout);
        this.timeout = setTimeout(() => {
          cb(results);
        }, 1000);
      },
      createFilter(queryString) {
        return (name) => {
          return (name.value.toLowerCase().indexOf(queryString.toLowerCase()) !== -1);
        };
      }
    },
    async mounted() {
      const names = await this.$axios.$get(process.env.browserBaseUrl + '/api/users/get_user_names')
      // 配列の要素を名前の文字列から { value: 名前 } のオブジェクト形式に変換
      const objNames = names.map( v => {
        return { value: v }
      })
      this.userNames = objNames;
    }
  };
</script>