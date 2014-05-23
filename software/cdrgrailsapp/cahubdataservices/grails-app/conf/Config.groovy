import grails.util.Environment
import nci.obbr.cahub.util.UserLogin

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
    xml: ['text/xml', 'application/xml'],
    text: 'text/plain',
    js: 'text/javascript',
    rss: 'application/rss+xml',
    atom: 'application/atom+xml',
    css: 'text/css',
    csv: 'text/csv',
    all: '*/*',
    json: ['application/json','text/json'],
    form: 'application/x-www-form-urlencoded',
    multipartForm: 'multipart/form-data'
]

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
grails.views.javascript.library="jquery"

grails.plugins.appinfo.useContextListener = true

grails.plugins.dynamicController.mixins = [
   'com.burtbeckwith.grails.plugins.appinfo.IndexControllerMixin':       'com.burtbeckwith.appinfo.AppinfoController',
   'com.burtbeckwith.grails.plugins.appinfo.HibernateControllerMixin':   'com.burtbeckwith.appinfo.AppinfoController',
   'com.burtbeckwith.grails.plugins.appinfo.Log4jControllerMixin' :      'com.burtbeckwith.appinfo.AppinfoController',
   'com.burtbeckwith.grails.plugins.appinfo.SpringControllerMixin' :     'com.burtbeckwith.appinfo.AppinfoController',
   'com.burtbeckwith.grails.plugins.appinfo.MemoryControllerMixin' :     'com.burtbeckwith.appinfo.AppinfoController',
   'com.burtbeckwith.grails.plugins.appinfo.PropertiesControllerMixin' : 'com.burtbeckwith.appinfo.AppinfoController',
   'com.burtbeckwith.grails.plugins.appinfo.ScopesControllerMixin' :     'com.burtbeckwith.appinfo.AppinfoController',
   'com.burtbeckwith.grails.plugins.appinfo.ThreadsControllerMixin' :    'com.burtbeckwith.appinfo.AppinfoController'
]



//Set to '' by shivece for Grails 2.2.x upgrade. The loopback setting was causing the 302 redirect loop with CAS. 
//Removing for 1.3.7 appears to not affect functionality
//grails.server.port = System.getProperty('server.port')
//grails.server.loopback.url = "http://localhost:${grails.server.port}"
grails.server.loopback.url = ""

// set per-environment serverURL stem for creating absolute links
environments {
    if(!appName) appName = 'cahubdataservices'
    development {
        grails.serverURL = "${grails.server.loopback.url}/${appName}"
        grails.mail.host = "mailfwd.nih.gov"
        grails.mail.port="25"
        grails.mail.default.from="charles.shive@nih.gov"
    }

    ec2dev {
        grails.serverURL = "${grails.server.loopback.url}/${appName}"
        grails.mail.default.from="charles.shive@nih.gov"
        grails.mail.host = "smtp.comcast.net"
        grails.mail.username="drshivas"
        grails.mail.password="Welcome01"
        grails.mail.port="587"
    }

    ec2cdr {
        grails.serverURL = "${grails.server.loopback.url}/${appName}"
        grails.mail.default.from="charles.shive@nih.gov"
        grails.mail.host = "smtp.comcast.net"
        grails.mail.username="drshivas"
        grails.mail.password="Welcome01"
        grails.mail.port="587"
    }

    abccdev {
        grails.serverURL = "${grails.server.loopback.url}/${appName}"
        grails.mail.host = "mailfwd.nih.gov"
        grails.mail.port="25"
        grails.mail.default.from="charles.shive@nih.gov"
    }

    qa {
        grails.serverURL = "${grails.server.loopback.url}/${appName}"
        grails.mail.host = "mailfwd.nih.gov"
        grails.mail.port="25"
        grails.mail.default.from="charles.shive@nih.gov"
    }

    stage {
        grails.serverURL = "${grails.server.loopback.url}/${appName}"
        grails.mail.host = "mailfwd.nih.gov"
        grails.mail.port="25"
        grails.mail.default.from="charles.shive@nih.gov"
    }

    production {
        grails.serverURL = "${grails.server.loopback.url}/${appName}"
        grails.mail.host = "mailfwd.nih.gov"
        grails.mail.port="25"
        grails.mail.default.from="charles.shive@nih.gov"
    }
}

// log4j configuration
log4j = {
    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
        'org.codehaus.groovy.grails.web.pages', //  GSP
        'org.codehaus.groovy.grails.web.sitemesh', //  layouts
        'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
        'org.codehaus.groovy.grails.web.mapping', // URL mapping
        'org.codehaus.groovy.grails.commons', // core / classloading
        'org.codehaus.groovy.grails.plugins', // plugins
        'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
        'org.springframework',
        'org.hibernate',
        'org.hibernate.engine.Collections',
        'net.sf.ehcache.hibernate',
        'nci.obbr.cahub.util.CDRSessionListener',
        'net.bull.javamelody'

    warn   'org.mortbay.log'

    info   'nci.obbr.cahub.util.TextSearchController'
}

environments {
    development {
        log4j = {
            // in development mode, let's see all my log messages
            debug 'grails.app'
        }
    }

    ec2dev {
        def catalinaBase = System.properties.getProperty('catalina.base')
        if(!catalinaBase) catalinaBase = '.'   // just in case
        if(!appName) appName = 'cahubdataservices'   // just in case
        def logDirectory = "${catalinaBase}/logs"

        log4j = {
            debug 'grails.app'

            appenders {
                // set up a log file in the standard tomcat area; be sure to use .toString() with ${}
                rollingFile name:'tomcatLog', file:"${logDirectory}/${appName}.log".toString(), maxFileSize:'1024KB', maxBackupIndex: 20 
                'null' name:'stacktrace'
            }

            root {
                // change the root logger to my tomcatLog file
                error 'tomcatLog'
                additivity = true
            }

            // example for sending stacktraces to my tomcatLog file
            //error tomcatLog:'StackTrace'

            // set level for my messages; this uses the root logger (and thus the tomcatLog file)
            info 'grails.app'
        }
    }

    abccdev {
        def catalinaBase = System.properties.getProperty('catalina.base')
        if(!catalinaBase) catalinaBase = '.'   // just in case
        if(!appName) appName = 'cahubdataservices'   // just in case
        def logDirectory = "${catalinaBase}/logs"

        log4j = {
            appenders {
                // set up a log file in the standard tomcat area; be sure to use .toString() with ${}
                rollingFile name:'tomcatLog', file:"${logDirectory}/cahubdataservices.log".toString(), maxFileSize:'1024KB', maxBackupIndex: 20 
                'null' name:'stacktrace'
            }

            root {
                // change the root logger to my tomcatLog file
                error 'tomcatLog'
                additivity = true
            }

            // example for sending stacktraces to my tomcatLog file
            //error tomcatLog:'StackTrace'

            // set level for my messages; this uses the root logger (and thus the tomcatLog file)
            info 'grails.app'
        }
    }

    qa {
        def catalinaBase = System.properties.getProperty('catalina.base')
        if(!catalinaBase) catalinaBase = '.'   // just in case
        if(!appName) appName = 'cahubdataservices'   // just in case
        def logDirectory = "${catalinaBase}/logs"

        log4j = {
            appenders {
                // set up a log file in the standard tomcat area; be sure to use .toString() with ${}
                rollingFile name:'tomcatLog', file:"${logDirectory}/${appName}.log".toString(), maxFileSize:'1024KB', maxBackupIndex: 20 
                'null' name:'stacktrace'
            }

            root {
                // change the root logger to my tomcatLog file
                error 'tomcatLog'
                additivity = true
            }

            // example for sending stacktraces to my tomcatLog file
            //error tomcatLog:'StackTrace'

            // set level for my messages; this uses the root logger (and thus the tomcatLog file)
            info 'grails.app'
        }
    }

    stage {
        def catalinaBase = System.properties.getProperty('catalina.base')
        if(!catalinaBase) catalinaBase = '.'   // just in case
        if(!appName) appName = 'cahubdataservices'   // just in case
        def logDirectory = "${catalinaBase}/logs"

        log4j = {
            appenders {
                // set up a log file in the standard tomcat area; be sure to use .toString() with ${}
                rollingFile name:'tomcatLog', file:"${logDirectory}/${appName}.log".toString(), maxFileSize:'1024KB', maxBackupIndex: 20 
                'null' name:'stacktrace'
            }

            root {
                // change the root logger to my tomcatLog file
                error 'tomcatLog'
                additivity = true
            }

            // example for sending stacktraces to my tomcatLog file
            //error tomcatLog:'StackTrace'

            // set level for my messages; this uses the root logger (and thus the tomcatLog file)
            info 'grails.app'
        }
    }
}

grails.plugins.springsecurity.filterChain.chainMap = [
   '/rest/**': 'JOINED_FILTERS,-exceptionTranslationFilter',
   '/**': 'JOINED_FILTERS,-basicAuthenticationFilter,-basicExceptionTranslationFilter'
]

grails.plugins.springsecurity.useBasicAuth = true
grails.plugins.springsecurity.basic.realmName = "caHUB CDR Data Services"

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'nci.obbr.cahub.authservice.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'nci.obbr.cahub.authservice.UserRole'
grails.plugins.springsecurity.authority.className = 'nci.obbr.cahub.authservice.Role'

grails.plugins.springsecurity.ui.register.emailFrom = 'noreply@cahub.ncifcrf.gov'
grails.plugins.springsecurity.ui.register.emailSubject = 'caHUB CDR-DS Password Reset'

grails.plugins.springsecurity.ui.forgotPassword.emailBody = 'Dear $user.username,<br/><br/>You recently requested that your caHUB CDR account password be reset.<br/><br/>Please click <a href="$url">here</a> to reset your password, if you did request a password change. Otherwise, ignore this email and no change will be applied to your account.<br/><br/>caHUB CDR Administrator'
grails.plugins.springsecurity.ui.forgotPassword.emailFrom = 'noreply@cahub.ncifcrf.gov'
grails.plugins.springsecurity.ui.forgotPassword.emailSubject = 'caHUB CDR Account Password Reset'

grails.plugins.springsecurity.ui.expiredPassword.emailBody = 'Dear $username,<br/><br/>Your caHUB CDR account password is expired.<br/><br/>Please click <a href="$url">here</a> to change your password.<br/><br/>caHUB CDR Administrator'
grails.plugins.springsecurity.ui.expiredPassword.emailFrom = 'noreply@cahub.ncifcrf.gov'
grails.plugins.springsecurity.ui.expiredPassword.emailSubject = 'caHUB CDR Account Password Expired'

grails.plugins.springsecurity.ui.expiredPassword.reminder.emailBody = 'Dear $username,<br/><br/>Your caHUB CDR account password expires on $expireDate, which is $daysRemain from today.<br/><br/>Please click <a href="$url">here</a> to change your password before it expires.<br/><br/>caHUB CDR Administrator'
grails.plugins.springsecurity.ui.expiredPassword.reminder.emailFrom = 'noreply@cahub.ncifcrf.gov'
grails.plugins.springsecurity.ui.expiredPassword.reminder.emailSubject = 'Reminder: caHUB CDR Account Password Expiration'

//pessimistic lockdown setting, so you need to ALLOW all roles on URLs
grails.plugins.springsecurity.rejectIfNoRule = true

grails.plugins.springsecurity.controllerAnnotations.staticRules = [
    //system setting controllers
    '/user/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/role/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/userRole/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/securityInfo/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/appSetting/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/controllers.gsp':['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/auditLogEvent/**':['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/appinfo/**':['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/backoffice/**':['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/specimenDw/**':['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/caseDw/**':['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/monitoring/**':['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],    
    '/privilege/**':['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB_LDS'],

    //leave these alone.  these rules are needed for everyting to work properly
    '/login/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/logout/**': ['IS_AUTHENTICATED_FULLY'],
    '/register/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/plugins/**': ['IS_AUTHENTICATED_ANONYMOUSLY', 'IS_AUTHENTICATED_FULLY'],
    '/images/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/css/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/js/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],

    //for CAS server login page
    '/dmzUtils/getRemoteLoginBulletin': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/dmzUtils/getRemoteClientAppVersion': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/dmzUtils/getRemoteClientCBRIMSInfo': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/dmzUtils/setMilestone': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    
    //webapp controllers
    '/home/**': ['IS_AUTHENTICATED_FULLY'],
    '/home/bpvhome**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/home/gtexhome**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/home/brnhome**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_LDS','ROLE_NCI-FREDERICK_CAHUB'],
    '/home/prchome**': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/home/vocabhome**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/home/gtexbsshome**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/home/bpvbsshome**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/home/varihome**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI'],
    '/home/broadhome**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_BROAD'],
    '/home/mbbhome**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_MBB'],
    '/home/bpvelsihome**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],    
    '/home/ctchome**': ['IS_AUTHENTICATED_ANONYMOUSLY'],        
    '/home/choosehome**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],       
    
//    shivece removed GTEx BSS access to PRC reports and PRC data on rest controller on 4-30-13 as directed by BBRB due to incidental findings issues.		
//    '/rest/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_SERVICE','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],

//    '/gtexDonorVarsExport/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_SERVICE','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
//    '/cachedGtexDonorVarsExport/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_SERVICE','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],


    '/rest/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_SERVICE','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],	
    '/gtexDonorVarsExport/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_SERVICE','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/cachedGtexDonorVarsExport/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_SERVICE','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    
    '/caseRecord/emailCase**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/caseRecord/create**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/caseRecord/show**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/caseRecord/accessCtc': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/caseRecord/list**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/caseRecord/getSpecimenCount**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/caseRecord/view**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI','ROLE_ORG_BROAD'],
    '/caseRecord/display**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI','ROLE_ORG_BROAD'],
    '/caseRecord/getcaseid': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER', 'ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/caseRecord/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/caseRecord/showbpvdeident**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI'],
    '/candidateRecord/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/therapyRecord/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/caseRecord/changeCaseFastTrackStatus**': ['ROLE_ORG_BROAD','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    
    '/shippingEvent/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ORG_VARI'],
    '/processingEvent/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ORG_VARI'],    
    '/shipDiscrepancy/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],        
    '/kitRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/specimenRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/derivativeRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],    
    '/specimenRecord/update**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER', 'ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/slideRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/imageRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/SOPRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],

    '/tissueRecoveryGtex/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/tissueRecoveryBms/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/tissueRecoveryBrain/**': ['ROLE_ORG_MBB','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/donorEligibilityGtex/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],

    '/caseReportForm/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/cancerHistory/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/concomitantMedication/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/deathCircumstances/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/demographics/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/generalMedicalHistory/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/medicalHistory/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/serologyResult/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/surgicalProcedures/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    
//    shivece removed GTEx BSS access to PRC reports on 4-30-13 as directed by BBRB due to incidental findings issues.	
//    '/prcReport/**': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB'],
//    '/prcReport/view': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
//    '/prcReport/viewBms': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
//    '/prcReport/download': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],    
    
    
    '/prcReport/**': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB'],
    '/prcReport/view': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/prcReport/viewBms': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/prcReport/download': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],    
    
    '/feedback/**': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/feedback/view': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/feedbackFzn/**': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/feedbackFzn/view': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    
    '/prcReportFzn/**': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB'],
    '/prcReportFzn/view': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/prcForm/**': ['ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN'],


    '/bpvBloodForm/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvTissueForm/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvSlidePrep/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvCaseQualityReview/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvTissueProcessEmbed/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvSurgeryAnesthesiaForm/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvTissueGrossEvaluation/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvConsentEnrollment/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvScreeningEnrollment/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvTissueReceiptDissection/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvClinicalDataEntry/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvLocalPathReview/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvPrcPathReview/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvWorkSheet/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/bpvSixMonthFollowUp/**': ['ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],

    '/icdGtexSc/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/icdGtexRpci/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/icdGtexNdri/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],

    '/vocab/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],

    '/kitType/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/acquisitionType/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/containerType/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/acquisitionLocation/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/BSS/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/caseCollectionType/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/caseStatus/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/fixative/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/organization/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/shippingContentType/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/shippingEventType/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/study/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/studyPhase/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],    
    '/inventoryStatus/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/histologicType/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/transactionType/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/tumorStatus/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/deathCause/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/medicalCondition/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/prcSpecimenReport/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/protocol/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/chpTissueRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_LDS'],
    '/chpBloodRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_LDS'],
    '/dosageUnit/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/frequency/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/route/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/userLogin/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/myReport/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/module/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/formMetadata/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/sop/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/sopVersion/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/activityType/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/caseAttachmentType/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/queryType/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/queryStatus/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],

    '/textSearch/search': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER', 'ROLE_ORG_VARI', 'ROLE_ORG_BROAD','ROLE_ORG_MBB'],
    '/textSearch/searchBRN': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/textSearch/searchPRC': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/textSearch/searchPRCBms': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/textSearch/searchPRCBpv': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/textSearch/searchPRCBrn': ['ROLE_NCI-FREDERICK_CAHUB_PRC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/textSearch/searchBMS': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_BSS_NDRI'],
    '/textSearch/searchBPV': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN', 'ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC'],
    '/textSearch/searchCTC': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/textSearch/searchMBB': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_ORG_MBB'],
    '/textSearch/searchhome': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER', 'ROLE_ORG_VARI', 'ROLE_ORG_BROAD','ROLE_ORG_MBB'],
    '/textSearch/searchVari': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI', 'ROLE_ORG_BROAD'],
    '/textSearch/searchVariBpv': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI'],
    '/textSearch/searchVariBrn': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI'],
    '/textSearch/searchVariBms': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI', 'ROLE_ORG_BROAD'],
    '/textSearch/index_all': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/textSearch/index_obj': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/textSearch/update_age': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/textSearch/searchCandi*': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/textSearch/searchQt': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC', 'ROLE_ORG_VARI', 'ROLE_ORG_BROAD','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_NCI-FREDERICK_CAHUB'],
     '/textSearch/searchhomeCTC': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/fileUpload/delete': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC'],
    '/fileUpload/remove': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC'],
    '/fileUpload/edit': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC'],
    '/fileUpload/show': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC'],
    '/fileUpload/update': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC'],
    '/fileUpload/list': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ORG_MBB'],
    '/fileUpload/create': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ORG_MBB'],
    '/fileUpload/save': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ORG_MBB'],
    '/fileUpload/download': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ORG_MBB', 'ROLE_NCI-FREDERICK_CAHUB_LDS'],

    '/help/**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ORG_BROAD','ROLE_ORG_VARI'],

    '/rpc/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_SERVICE'],
    '/caseRecord/changeCaseStatus**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER', 'ROLE_NCI-FREDERICK_CAHUB_DM'],
    '/caseRecord/update**': ['ROLE_BSS_SC','ROLE_BSS_RPCI','ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER', 'ROLE_NCI-FREDERICK_CAHUB_DM'],
     '/caseRecord/changeCtcStatus': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/caseRecord/ctcUpdate': ['IS_AUTHENTICATED_ANONYMOUSLY'],

    //PMH 07/30
    '/appUsers/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/applicationListing/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/edit': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/create': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/save': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/list': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/submitRequest': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/completeRequest': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/assignRequest': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/cancelRequest': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/showDetail': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/acctStatus': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/show': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/editRequest': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER', 'ROLE_ORG_VARI'],
    '/accountStatus/updateRequest': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER', 'ROLE_ORG_VARI'],
    '/accountStatus/notifyAdmin': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER', 'ROLE_ORG_VARI'],
    '/appRequest/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountAction/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/createApprequest': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/accountStatus/mytest': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],

    '/helpFileUpload/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/activityEvent/**': ['IS_AUTHENTICATED_FULLY'],
    '/activitycenter/**': ['IS_AUTHENTICATED_FULLY'],
    '/vocab/**': ['IS_AUTHENTICATED_FULLY'],
    '/caseWithdraw/**': ['ROLE_BSS_RPCI', 'ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_BSS_VUMC','ROLE_NCI-FREDERICK_CAHUB_PRC', 'ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ORG_MBB', 'ROLE_BSS_SC'],
    '/query/**': ['ROLE_BSS_RPCI', 'ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ORG_MBB'],
    '/queryAttachment/**': ['ROLE_BSS_RPCI', 'ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ORG_MBB'],
    '/queryResponse/**': ['ROLE_BSS_RPCI', 'ROLE_BSS_NDRI','ROLE_BSS_UNM','ROLE_BSS_BMC','ROLE_BSS_UPMC','ROLE_BSS_EU','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN','ROLE_ORG_VARI','ROLE_ORG_BROAD','ROLE_ORG_MBB'],
    '/deviation/**': ['ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    
    //used only for QA and test environments.
    '/randomCaseSequence/**': ['ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    
    //audit log trail
    '/trailAuditLog/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'], 
    
    //survey area
    '/surveyQuestion/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],
    '/surveyTemplate/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],
    '/surveySection/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],
    '/surveyQuestionOption/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],    
    '/surveyAnswer/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],
    '/surveyRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI','ROLE_BPV_ELSI_DA'],
    '/interviewRecord/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],        
    '/interviewRecord/edit**': ['ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/interviewRecord/list/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI','ROLE_BPV_ELSI_DA'],        
    '/interviewRecord/show/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI_DA','ROLE_BPV_ELSI'],            
    '/survey.html': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],
    '/bpvElsiCrf/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],
    '/bpvElsiCrf/create/**': ['ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],
    '/bpvElsiCrf/edit/**': ['ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],
    '/bpvElsiCrf/show/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI','ROLE_BPV_ELSI_DA'],
    '/bpvElsiCrf/list/**': ['ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER'],
    '/survey/edit/**': ['ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI'],
    '/survey/show/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_NCI-FREDERICK_CAHUB_DM','ROLE_ADMIN','ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_BPV_ELSI','ROLE_BPV_ELSI_DA'],
    
    '/iconbuilder/**': ['IS_AUTHENTICATED_FULLY'],
    '/goal/**': ['ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN'],
    '/patientRecord/**': ['IS_AUTHENTICATED_FULLY'],
    '/ctcCrf/**': ['IS_AUTHENTICATED_FULLY'],
    '/brainBankFeedback/**': ['ROLE_NCI-FREDERICK_CAHUB','ROLE_ADMIN','ROLE_ORG_MBB']
]

grails.plugins.springsecurity.useSecurityEventListener = true

grails.plugins.springsecurity.failureHandler.exceptionMappings = [
   'org.springframework.security.authentication.CredentialsExpiredException':   '/register/expiredPassword'
]

/* Externalize config for Config.groovy and DataSource.groovy */
/**
 * Running externalized configuration
 * Assuming the following configuration files
 * - in the executing user's home at /var/storage/<app_name>/[Config.groovy|DataSource.groovy]
 * - config location set path by system variable '<APP_NAME>_CONFIG_LOCATION'
 * - dataSource location set path by system environment variable '<APP_NAME>_DATASOURCE_LOCATION'
 */
grails.config.locations = []
def foundConfigFlag = false
def foundDataSourceFlag = false

def defaultConfigFiles = ["/var/storage/conf/${appName}/Config.groovy",
                          "/var/storage/conf/${appName}/DataSource.groovy"]

defaultConfigFiles.each { filePath ->
    def f = new File(filePath)
    if(f.exists()) {
        if(filePath.contains("Config.groovy")) {
            foundConfigFlag = true
        } else {
            if(filePath.contains("DataSource.groovy")) {
                foundDataSourceFlag = true
            }
        }
        grails.config.locations << "file:${filePath}"
    }
}

if(!foundConfigFlag || !foundDataSourceFlag) {
    String bashSafeEnvAppName = appName.toUpperCase(Locale.ENGLISH).replaceAll(/-/, '_')
    if(!foundConfigFlag) {
        def externalConfig = System.getenv("${bashSafeEnvAppName}_CONFIG_LOCATION")
        if(externalConfig) {
            def f = new File(externalConfig)
            if(f.exists()) {
                foundConfigFlag = true
                grails.config.locations << "file:" + externalConfig
            } else {
                throw new RuntimeException( "[ERROR] External configuration specified for Config.groovy does not exist!! Please verify the correct file location: "+ bashSafeEnvAppName + "_CONFIG_LOCATION=/var/storage/conf/cahubdataservices/Config.groovy in tomcat6.conf")
            }
        } else {
            if(Environment.current != Environment.DEVELOPMENT) {
                println "throw exception here if env != development"
                throw new RuntimeException( "[ERROR] No external configuration location found for Config.groovy!! Add: "+ bashSafeEnvAppName + "_CONFIG_LOCATION=/var/storage/conf/cahubdataservices/Config.groovy in tomcat6.conf")
            }
        }
    }

    if(!foundDataSourceFlag) {
        def externalDataSource = System.getenv("${bashSafeEnvAppName}_DATASOURCE_LOCATION")
        if(externalDataSource) {
            def f = new File(externalDataSource)
            if(f.exists()) {
                foundDataSourceFlag = true
                grails.config.locations << "file:" + externalDataSource
            } else {
                throw new RuntimeException( "[ERROR] External configuration specified for DataSource.groovy does not exist!! Please verify the correct file location: "+ bashSafeEnvAppName + "_DATASOURCE_LOCATION=/var/storage/conf/cahubdataservices/DataSource.groovy in tomcat6.conf")
            }
        } else {
            if(Environment.current != Environment.DEVELOPMENT) {
                println "throw exception here if env != development"
                throw new RuntimeException( "[ERROR] No external configuration location found for DataSource.groovy!! Add: "+ bashSafeEnvAppName + "_DATASOURCE_LOCATION=/var/storage/conf/cahubdataservices/DataSource.groovy in tomcat6.conf")
            }
        }
    }
}

if(!foundConfigFlag || !foundDataSourceFlag) {
    /* Can't use log.error() here! */
    println "Danger, Will Robinson! " + " Required config files not found in default locations, and no environment variable appears to be configured!"
    println Environment.dump()
    throw new RuntimeException( "[ERROR] No external configuration location found for Config.groovy!! Try: EXPORT "+ bashSafeEnvAppName + "_CONFIG_LOCATION=/var/storage/conf/cahubdataservices/Config.groovy " + "[ERROR] No external DataSource location found for DataSource.groovy!! Try: EXPORT "+ bashSafeEnvAppName + "_DATASOURCE_LOCATION=/var/storage/conf/cahubdataservices/DataSource.groovy")
}

grails.config.locations.each {
    /* Can't use log.info() here! */
    println "[INFO] Including configuration file [${it}] in configuration building."
}
