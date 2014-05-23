package nci.obbr.cahub

import grails.converters.JSON
import nci.obbr.cahub.util.AppSetting


class dmzUtilsController {
    def grailsApplication

    def getRemoteLoginBulletin = {
        def bulletin = [:]
        def appSettingInstance = AppSetting.findByCode('LOGIN_BULLETIN')

        if(!appSettingInstance?.bigValue) {
            bulletin.put("loginBulletin", "bulletin app setting not found")
        } else {
            bulletin.put("loginBulletin", appSettingInstance.bigValue)
        }

        if(params.callback) {
            render "${params.callback.encodeAsURL()}([${bulletin as JSON}])"
        } else {
            render bulletin as JSON
        }
    }

    def getRemoteClientAppVersion = {
        def milestone = AppSetting.findByCode('APP_RELEASE_MILESTONE')?.bigValue
        def appVersion = ["version":"${grailsApplication.metadata.'app.version'}","milestone":"${milestone?"$milestone":""}"]
        if(params.callback) {
            render "${params.callback.encodeAsURL()}([${appVersion as JSON}])"
        } else {
            render appVersion as JSON
        }
    }

    def getRemoteClientCBRIMSInfo = {
        def cbrIMSInfo = ["cbrIMSHost":"${AppSetting.findByCode('CBR_IMS_HOST')?.value}","cbrIMSName":"${AppSetting.findByCode('CBR_IMS_NAME')?.value}"]
        if(params.callback) {
            render "${params.callback.encodeAsURL()}([${cbrIMSInfo as JSON}])"
        } else {
            render cbrIMSInfo as JSON
        }
    }
    
    def setMilestone = {
        
        def m = AppSetting.findByCode('APP_RELEASE_MILESTONE')
        m.bigValue = params.m
        m.save(failOnError: false, flush: true)
        redirect(uri:"/")
        
    }
}