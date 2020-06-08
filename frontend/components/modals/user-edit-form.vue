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
      <el-form-item label="icon" :label-width="formLabelWidth">
        <el-upload
          class="upload-demo"
          action="#"
          :on-preview="handlePreview"
          :on-remove="handleRemove"
          :file-list="fileList"
          :on-change="handleAdd"
          list-type="picture">
          <el-button size="small" type="primary" style="margin-right: 30px;">Click to upload</el-button>
          <span slot="tip" class="el-upload__tip">jpg/png files with a size less than 500kb</span>
        </el-upload>
      </el-form-item>
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
      email: this.$props.currentUser.email,
      fileList: [],
      imageFile: ""
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
      // formData
      let formData = new FormData()
      formData.append("name", this.name)
      formData.append("email", this.email)
      if (this.imageFile !== null ){
        formData.append("image", this.imageFile)
      }
      await this.$axios.$put( process.env.browserBaseUrl + '/api/auth', formData,{
        headers: {
            "Content-Type": "multipart/form-data"
        }
      }).then( res => {
        console.log('res desuyo')
        console.log(res)
        this.$store.commit('auth/setCurrentUser', res.data )
        this.handleClose(false)
      }).catch( err => {
        console.log('err')
      })
    },
    handleAdd: function (file, fileList) {
      this.fileList = fileList
      this.imageFile = fileList[0].raw
      console.log('handleAdd')
      console.log(file)
      console.log(fileList)
    },
    handleRemove(file, fileList) {
        console.log(file, fileList);
    },
    handlePreview(file) {
        console.log('file')
        console.log(file);
        this.image = file.raw
    },
  }
};
</script>