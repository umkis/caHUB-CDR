package nci.obbr.cahub.util
import java.text.SimpleDateFormat
import grails.plugins.springsecurity.Secured
    
class UserLoginController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }
    
    def list = {
        
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        SimpleDateFormat df2 = new SimpleDateFormat("MM/dd/yyyy");
        def start=params.start
        def end = params.end

        def startD = parseDateTime(start)
        def endD = parseDateTime(end)
        
        def userName = params.userName
        def organization = params.organization
        
        if (userName?.trim().equals("")) userName = null
        if (organization?.trim().equals("")) organization = null
        
        if ((userName)&&(organization))
        {
            organization = null
        }
        
        def max = Math.min(params.max ? params.int('max') : 25, 100)
        def offset = params.offset ? params.int('offset') : 0
        
        def resultsByDate
        def search_range
        if(startD && endD)
        {
            resultsByDate = UserLogin.findAllByLoginDateBetween(startD, endD)
            search_range = "[" + df.format(startD) + ", " + df.format(endD) + "]"
        }
        else if(startD && !endD)
        {
            resultsByDate = UserLogin.findAllByLoginDateGreaterThan(startD)
            search_range = "[" + df.format(startD) + ", *" + "]"
        }
        else if(!startD && endD)
        { 
            resultsByDate = UserLogin.findAllByLoginDateLessThan(endD)
            search_range = "[*" +", " + df.format(endD) + "]"
        }
        else
        {
            def today = df2.format(new Date())
            startD= df.parse( today + " 00:00")
            resultsByDate = UserLogin.findAllByLoginDateGreaterThan(startD)
            search_range = "["+ today + " 00:00"  +", "  + "*]"
        }
        
        String orgn
        if (organization?.endsWith("*"))
        {
            orgn = organization
            while(orgn.endsWith("*")) orgn = orgn.substring(0, orgn.length()-1)
            organization = orgn + "*"
        }
        
        def results = []
        //def resultList = []
        int size = 0
        
        if (resultsByDate)
        {
            resultsByDate.each
            {
                def passed = false
                
                if (userName)
                {
                    if (userName.equalsIgnoreCase(it.username)) passed = true
                }
                else if (organization)
                {
                    if (orgn)
                    {
                        if (it.organization)
                        {
                            String r = it.organization
                            if (r.toLowerCase().startsWith(orgn.toLowerCase())) passed = true
                        }
                    }
                    else
                    {
                        if (organization.equalsIgnoreCase(it.organization))
                        {
                            passed = true
                        }
                        else if (organization.equalsIgnoreCase("bbrb")) 
                        {
                            if (("obbr").equalsIgnoreCase(it.organization)) passed = true
                        }
                        else if (organization.equalsIgnoreCase("obbr")) 
                        {
                            if (("bbrb").equalsIgnoreCase(it.organization)) passed = true
                        }
                    }
                }
                else passed = true
                
                if (passed)
                {
                    size++
                    //resultList.add(it)
                    //if ((resultList.size() > offset)&&(results.size() < max))
                    if ((size > offset)&&(results.size() < max))
                    {
                        results.add(it)   
                    }
                }
            }
        }
        //resultsByDate = resultList
        
       
        //println("UserLoginController results.size()=" + results.size() + ", size=" + size)//resultList.size())
        // [userLoginInstanceList:results, userLoginInstanceTotal:size, start:start, end:end, search_range:search_range]
        [userLoginInstanceList:results, userLoginInstanceTotal:size, start:startD, end:endD, search_range:search_range,userName:userName, organization:organization]
    }
    
    
    
    /*
    def list = {
        
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        SimpleDateFormat df2 = new SimpleDateFormat("MM/dd/yyyy");
        def start=params.start
        def end = params.end

        def results
        def size = 0
        def startD = parseDateTime(start)
        def endD = parseDateTime(end)
        def search_range
        def userName = params.userName
        def organization = params.organization
        //println("UserLoginController 1 organization=" + organization)
        if (userName?.trim().equals("")) userName = null
        if (organization?.trim().equals("")) organization = null
        
        if ((userName)&&(organization))
        {
            organization = null
        }
        
         params.max = Math.min(params.max ? params.int('max') : 25, 100)
        if(startD && endD)
        {
            //println "PMH START "+start
              //startD = df.parse(start)
              //endD = df.parse(end)
            //size = UserLogin.findAllByLoginDateBetween(startD, endD).size()
            if(userName)
            {
                results = UserLogin.findAllByUsernameAndLoginDateBetween(userName, startD, endD,  params)
                size = UserLogin.findAllByUsernameAndLoginDateBetween(userName,startD, endD).size()
            }
            else if(organization)
            {
                results = UserLogin.findAllByOrganizationAndLoginDateBetween(organization, startD, endD,  params)
                size = UserLogin.findAllByOrganizationAndLoginDateBetween(organization, startD, endD).size()
            }
            else
            {
                results= UserLogin.findAllByLoginDateBetween(startD, endD,  params)
                size=UserLogin.findAllByLoginDateBetween(startD, endD).size()
            }
            search_range = "[" + df.format(startD) + ", " + df.format(endD) + "]"
        }
        else if(startD && !endD)
        {
               //startD = df.parse(start)
             //size = UserLogin.findAllByLoginDateGreaterThan(startD).size()
             if(userName)
             {
                 results= UserLogin.findAllByUsernameAndLoginDateGreaterThan(userName,startD, params)
                 size=UserLogin.findAllByUsernameAndLoginDateGreaterThan(userName,startD).size()
             }
             else if(organization)
             {
                 results= UserLogin.findAllByOrganizationAndLoginDateGreaterThan(organization, startD, params)
                 size=UserLogin.findAllByOrganizationAndLoginDateGreaterThan(organization, startD).size()
             }
             else
             {
                 results= UserLogin.findAllByLoginDateGreaterThan(startD, params)
                 size=UserLogin.findAllByLoginDateGreaterThan(startD).size()
             }
             
              search_range = "[" + df.format(startD) + ", *" + "]"
            
        }
        else if(!startD && endD)
        { 
            //endD = df.parse(end)
              //size = (UserLogin.findAllByLoginDateLessThan(endD)).size()
              //println("size: " + size)
              if(userName)
              {
                  results = UserLogin.findAllByUsernameAndLoginDateLessThan(userName,endD,  params)
                  size = UserLogin.findAllByUsernameAndLoginDateLessThan(userName,endD).size()
              }
              else if(organization)
              {
                  results = UserLogin.findAllByOrganizationAndLoginDateLessThan(organization, endD,  params)
                  size = UserLogin.findAllByOrganizationAndLoginDateLessThan(organization, endD).size()
              }
              else
              {
                  results= UserLogin.findAllByLoginDateLessThan(endD,  params)
                  size=UserLogin.findAllByLoginDateLessThan(endD).size()
              }
            
              search_range = "[*" +", " + df.format(endD) + "]"
        }
        else
        {
            def today = df2.format(new Date())
            startD= df.parse( today + " 00:00")
            
             //size = UserLogin.findAllByLoginDateGreaterThan(startD).size()
             if(userName)
             {
                 results = UserLogin.findAllByUsernameAndLoginDateGreaterThan(userName,startD, params)
                 size = UserLogin.findAllByUsernameAndLoginDateGreaterThan(userName,startD).size()
             }
             else if(organization)
             {
                 results = UserLogin.findAllByOrganizationAndLoginDateGreaterThan(organization, startD, params)
                 size = UserLogin.findAllByOrganizationAndLoginDateGreaterThan(organization, startD).size()
             }
             else
             {
                 results = UserLogin.findAllByLoginDateGreaterThan(startD, params)
                 size = UserLogin.findAllByLoginDateGreaterThan(startD).size()
             }

             search_range = "["+ today + " 00:00"  +", "  + "*]"
            
          
        }
        
        
       
       println("UserLoginController results.size()=" + results.size() + ", size=" + size)
       // [userLoginInstanceList:results, userLoginInstanceTotal:size, start:start, end:end, search_range:search_range]
        [userLoginInstanceList:results, userLoginInstanceTotal:size, start:startD, end:endD, search_range:search_range,userName:userName, organization:organization]
    }
    */
    def create = {
        def userLoginInstance = new UserLogin()
        userLoginInstance.properties = params
        return [userLoginInstance: userLoginInstance]
    }

    def save = {
        def userLoginInstance = new UserLogin(params)
        if (userLoginInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'userLogin.label', default: 'UserLogin'), userLoginInstance.id])}"
            redirect(action: "show", id: userLoginInstance.id)
        }
        else {
            render(view: "create", model: [userLoginInstance: userLoginInstance])
        }
    }

    def show = {
        def userLoginInstance = UserLogin.get(params.id)
        if (!userLoginInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userLogin.label', default: 'UserLogin'), params.id])}"
            redirect(action: "list")
        }
        else {
            [userLoginInstance: userLoginInstance]
        }
    }

    def edit = {
        def userLoginInstance = UserLogin.get(params.id)
        if (!userLoginInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userLogin.label', default: 'UserLogin'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userLoginInstance: userLoginInstance]
        }
    }

    def update = {
        def userLoginInstance = UserLogin.get(params.id)
        if (userLoginInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userLoginInstance.version > version) {
                    
                    userLoginInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'userLogin.label', default: 'UserLogin')] as Object[], "Another user has updated this UserLogin while you were editing")
                    render(view: "edit", model: [userLoginInstance: userLoginInstance])
                    return
                }
            }
            userLoginInstance.properties = params
            if (!userLoginInstance.hasErrors() && userLoginInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'userLogin.label', default: 'UserLogin'), userLoginInstance.id])}"
                redirect(action: "show", id: userLoginInstance.id)
            }
            else {
                render(view: "edit", model: [userLoginInstance: userLoginInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userLogin.label', default: 'UserLogin'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_NCI-FREDERICK_CAHUB_SUPER','ROLE_ADMIN']) 
    def delete = {
        def userLoginInstance = UserLogin.get(params.id)
        if (userLoginInstance) {
            try {
                userLoginInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'userLogin.label', default: 'UserLogin'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'userLogin.label', default: 'UserLogin'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userLogin.label', default: 'UserLogin'), params.id])}"
            redirect(action: "list")
        }
    }
    
    Date parseDateTime(String date)
    {
        if (!date) return null
        String dateStr = date.trim()
        if (dateStr.equals("")) return null
        if (dateStr.equalsIgnoreCase('select date')) return null
        
        int n = 0
        
        def format
        SimpleDateFormat df 
        Date value
        while(true)
        {
            if (n == 0)
            {
                format = "MM/dd/yyyy HH:mm"
            }
            else if (n == 1)
            {
                format = "MM/dd/yyyy"
            }
            else if (n == 2)
            {
                format = "EEE MMM dd HH:mm:ss z yyyy"
            }
            df = new SimpleDateFormat(format);
            try
            {
                value = df.parse(dateStr)
                break
            }
            catch(java.text.ParseException pe)
            {
                if (n == 2)
                {
                    println("UserLoginController Date value parsing failure: '" + date + "' - " + pe.getMessage())
                    return null
                }
            }
            n++
        }
        return value
    }
    
}
