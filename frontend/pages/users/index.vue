<template>
  <el-main class="users_index_wrapper">
    <el-row>
      <el-col :md="14" :span="24">
        <el-tabs v-model="tabActive" @tab-click="handleSelectUsers">
          <el-tab-pane label="Followings" name="first">
            <div class="users">
              <userIndexCard v-for="u in followings" :user="u" :key="u.id" />
            </div>
          </el-tab-pane>
          <el-tab-pane label="Followers" name="second">
            <div class="users">
              <userIndexCard v-for="u in followers" :user="u" :key="u.id" />
            </div>
          </el-tab-pane>
        </el-tabs>
      </el-col>
      <el-col :md="10" :span="24" style="height: 90vh; background: #ddd;text-align: center;">
        <p style="font-weight: bold;padding: 20px;margin: 0 20px;border-bottom: 1px solid #555;">Search by all Users</p>
        <el-autocomplete
          v-model="searchKeyword"
          :fetch-suggestions="querySearchAsync"
          placeholder="Please input"
          style="margin: 20px 0;"
        >
          <el-button @click="searchUsers" slot="append" icon="el-icon-search"></el-button>
        </el-autocomplete>
        <div style="overflow-y: scroll;height: 75%;padding: 5px;display: flex; flex-wrap: wrap;justify-content: space-around;align-items: flex-start;">
          <userIndexCard v-for="u in searchedUsers" :user="u" :key="u.id" />
        </div>
      </el-col>
    </el-row>
  </el-main>
</template>
</template>

<script>
import userIndexCard from '~/components/user-index-card.vue'
export default {
  async asyncData({ $axios, store }){
    const baseUrl = process.client ? process.env.browserBaseUrl : process.env.apiBaseUrl
    const user = await $axios.$get(baseUrl + `/api/users/${store.state.auth.currentUser.id}`)
    return {
      followings: user.followings,
      followers: user.followers,
      allUsers: [],
      searchedUsers: [],
      tabActive: 'first',
      userNames: [],
      searchKeyword: '',
      timeout:  null
    }
  },
  methods: {
    async handleSelectUsers(tab){
      console.log(tab.label)
      switch (tab.label){
        case 'All users':
          const allUsersData = await this.$axios.$get(process.env.browserBaseUrl + '/api/users')
          this.allUsers = allUsersData
          break   
      }
    },
    async handleTabClick(tab){
      console.log(tab.label)
      switch (tab.label){
        case 'Followings':
          const followingsData = await this.$axios.$get(process.env.browserBaseUrl + '/api/users/followings', {
            params: { id: this.$store.state.auth.currentUser.id }
          })
          this.users = followingsData
          break   
        case 'Followers':
          const followersData = await this.$axios.$get(process.env.browserBaseUrl + '/api/users/followers', {
            params: { id: this.$store.state.auth.currentUser.id }
          })
          this.users = followersData
          break
        case 'All users':
          const allUsersData = await this.$axios.$get(process.env.browserBaseUrl + '/api/users')
          this.users = allUsersData
          break   
      }
    },
    async searchUsers(){
      const searchedUsers = await this.$axios.$get(process.env.browserBaseUrl + '/api/users/search', {
        params: { query: this.searchKeyword }
      })
      this.searchedUsers = searchedUsers
    },
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
  },
  components: {
    userIndexCard
  }
}
</script>

<style>
.users_index_wrapper {
  height: 100vh;
  padding: 60px 60px 0;
}
.users_index_wrapper .users {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  align-items: flex-start;
  align-content: flex-start;
  height: 90%;
  padding: 30px 0;
  background: #f1decc;
}
.users_index_wrapper .el-card {
  margin-bottom: 20px;
}
.users_index_wrapper .nameplate {
  display: flex;
  align-items: center;
}
.users_index_wrapper .actions {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  margin: 20px 0 0;
}
.users_index_wrapper a {
  padding: 0;
  color: #333;
}
.users_index_wrapper .el-tabs__content {
  background: #f1decc;
  height: 80vh;
}
.users_index_wrapper .el-tabs__header {
  background: #f1decc;
  padding: 20px;
  margin: 0;
}
@media (min-width: 0px) and (max-width: 768px) {
  .users_index_wrapper {
    padding: 70px 0;
  }
  .users_index_wrapper .el-tabs__content {
    height: 72vh;
  }
}
</style>