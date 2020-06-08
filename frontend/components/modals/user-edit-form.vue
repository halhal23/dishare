<template>
  <el-dialog
    title="EDIT FORM"
    :visible.sync="userEditFormModal"
    :before-close="handleClose">
    <el-form>
      <el-form-item label="name" :label-width="formLabelWidth">
        <el-input v-model="name" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="email" :label-width="formLabelWidth">
        <el-input v-model="email" autocomplete="off"></el-input>
      </el-form-item>
      <!-- <el-form-item label="Zones" :label-width="formLabelWidth">
        <el-select v-model="email" placeholder="Please select a zone">
          <el-option label="Zone No.1" value="shanghai"></el-option>
          <el-option label="Zone No.2" value="beijing"></el-option>
        </el-select>
      </el-form-item> -->
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">Cancel</el-button>
      <el-button type="primary" @click="updateUser">Submit</el-button>
    </span>
  </el-dialog>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  data(){
    return {
      formLabelWidth: '120px',
      name: this.$props.currentUser.name,
      email: this.$props.currentUser.email
    }
  },
  // computed: {
  //   ...mapGetters({
  //     currentUser: 'auth/currentUser'
  //   })
  // },
  props: {
    userEditFormModal: Boolean,
    currentUser: Object
  },
  methods: {
    handleClose(done) {
      this.$emit('onModal')
    },
    async updateUser(){
      console.log('update desu')
      console.log(this)
      // console.log(this.fileList[0])
      // console.log(this.fileList[0].raw)
      // formData
      let formData = new FormData()
      formData.append("name", this.name)
      formData.append("email", this.email)
      // formData.append("image", this.imageFile)
      await this.$axios.$put( process.env.browserBaseUrl + '/api/auth', formData,{
        headers: {
            "Content-Type": "multipart/form-data"
        }
      }).then( res => {
        console.log('res desuyo')
        console.log(res)
        this.$store.commit('auth/setCurrentUser', res.data )
        // this.handleClose(false)
      }).catch( err => {
        console.log('err')
      })
    },
  }
};
</script>