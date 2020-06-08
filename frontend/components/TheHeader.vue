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
        <a href="#" @click="dialogFormVisible = true" v-if="!$store.state.auth.isLoggedIn">ログイン</a>
        <nuxt-link to="/users/mypage" v-else>{{ $store.state.auth.currentUser.name }}</nuxt-link>
      </li>
      <li>
        <a href="#" @click="dialogSignUpVisible = true" v-if="!$store.state.auth.isLoggedIn">新規登録</a>
        <a href="#" @click="logout" v-else>ログアウト</a>
      </li>
    </ul>
  </header>

  <el-dialog class="login" :center="true" title="ログイン" :visible.sync="dialogFormVisible">
    <el-form :modle="form">
      <el-form-item label="名前" :label-width="formLabelWidth">
        <el-input v-model="form.name" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="メールアドレス" :label-width="formLabelWidth">
        <el-input v-model="form.email" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="パスワード" :label-width="formLabelWidth">
        <el-input v-model="form.password" show-password></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">キャンセル</el-button>
      <el-button type="primary" @click="signIn(form)">ログイン</el-button>
    </span>
  </el-dialog>

  <el-dialog class="signUp" :center="true" title="新規登録" :visible.sync="dialogSignUpVisible">
    <el-form :modle="form">
      <el-form-item label="名前" :label-width="signUpLabelWidth">
        <el-input v-model="form.name" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="メールアドレス" :label-width="signUpLabelWidth">
        <el-input v-model="form.email" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="パスワード" :label-width="signUpLabelWidth">
        <el-input v-model="form.password" show-password></el-input>
      </el-form-item>
      <el-form-item label="パスワード(確認用)" :label-width="signUpLabelWidth">
        <el-input v-model="form.password_confirmation" show-password></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="dialogSignUpVisible = false">キャンセル</el-button>
      <el-button type="primary" @click="signUp(form)">送信</el-button>
    </span>
  </el-dialog>
</div>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data(){
    return {
      dialogFormVisible: false,
      dialogSignUpVisible: false,
      form: {
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      },
      formLabelWidth: '120px',
      signUpLabelWidth: '150px',
    }
  },

  methods: {
    signIn(formData){
      this.login(formData)
      this.dialogFormVisible = false
    },
    ...mapActions({
      login: 'auth/login',
      logout: 'auth/logout',
      signUp: 'auth/signUp',
    }),
    hello(){
      console.log('helo')
    }
  }
}
</script>

<style>
/* header {
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
} */

.header-wrapper .login .el-dialog{
  height: 300px;
}
.header-wrapper .signUp .el-dialog{
  height: 500px;
}

</style>