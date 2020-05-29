<template>
<div class="header-wrapper">
  <header>
    <ul>
      <li>
        <nuxt-link to="/">ホーム</nuxt-link>
      </li>
      <li>
        <nuxt-link to="/">このサイトについて</nuxt-link>
      </li>
      <li>
        <img src="images/text-logo.png" height="70px" width="210px">
      </li>
      <li>
        <a href="#" @click="dialogFormVisible = true" v-if="!$auth.$state.loggedIn">ログイン</a>
        <a href="#" @click="logout" v-else>ログアウト</a>
      </li>
      <li>
        <nuxt-link to="/">新規登録</nuxt-link>
      </li>
    </ul>
  </header>

  <el-dialog :center="true" title="ログイン" :visible.sync="dialogFormVisible">
    <el-form :modle="form">
      <el-form-item label="名前" :label-width="formLabelWidth">
        <el-input v-model="form.name" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="パスワード" :label-width="formLabelWidth">
        <el-input v-model="form.password" show-password></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">キャンセル</el-button>
      <el-button type="primary" @click="login">ログイン</el-button>
    </span>
  </el-dialog>
</div>
</template>

<script>
export default {
  data(){
    return {
      dialogFormVisible: false,
      form: {
        name: '',
        password: ''
      },
      formLabelWidth: '120px'
    }
  },

  methods: {
    async login() {
      await this.$auth.loginWith('local', {
        data: {
          name: this.form.name,
          password: this.form.password,
          password_confirmation: this.form.password
        }
      })
        .then( res => {
          console.log('ログイン成功' + ' /pages/login.vue')
          console.log(res)
          this.dialogFormVisible = false
          return res
        }, err => {
          console.log('ログイン失敗' + ' /pages/login.vue')
          console.log(err)
          return err
        })
    },
    async logout(){
      console.log(this.$store)
      await this.$auth.logout({
          name: 'halhal'
      }).then( res => {
        console.log('ログアウト成功')
        console.log(res)
        return res
      }).catch( err => {
        console.log('ログアウト失敗')
        console.log(err)
        return err
      })
    }
  }
}
</script>

<style>
header {
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 2;
  background: rgba(255,255,255,0.5)
}

ul {
  display: flex;
  justify-content: space-around;
}

li {
  text-decoration: none;
  list-style: none;
}

a {
  line-height: 70px;
  text-decoration: none;
  color: black;
}

.header-wrapper .el-dialog{
  height: 300px;
}

</style>