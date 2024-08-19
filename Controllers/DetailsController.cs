using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using task5.Models;

namespace task5.Controllers
{
    public class DetailsController : Controller
    {
        private Repository _repository = new Repository();
        private List<Details> model;

        //  private IEnumerable<object> model;

        [HttpGet]
        public ActionResult Index()
        {
            // Initialize ViewBag.States and ViewBag.Cities
            ViewBag.States = new SelectList(_repository.GetStates(), "StateId", "StateName");
            ViewBag.Cities = new SelectList(Enumerable.Empty<SelectListItem>(), "Value", "Text");
            //  ViewBag.Cities = new SelectList(_repository.GetCities(StateId), "Value", "Text");
            //  ViewBag.Cities = Details.StateId > 0 ? GetCities(candidate.StateId) : new List<City>();
            // Initialize model
            var model = new Details();
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(Details s)
        {
            if (ModelState.IsValid)
            {
                _repository.Register(s);
                return RedirectToAction("GetDetails");
            }

            // Re-populate ViewBag on failed validation
            ViewBag.States = new SelectList(_repository.GetStates(), "StateId", "StateName");
            ViewBag.Cities = new SelectList(Enumerable.Empty<SelectListItem>(), "Value", "Text");
           
            return View(s);
        }

        [HttpGet]
        public JsonResult GetCitiesByStateId(string stateId)
        {
            if (string.IsNullOrEmpty(stateId))
            {
                return Json(new List<City>(), JsonRequestBehavior.AllowGet);
            }

            var cities = _repository.GetCities(stateId);
            return Json(cities, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDeatils1(string stateName)
        {
            
            var obj = TempData["Data"];
             return RedirectToAction("GetDetails", obj);
            return View();
        }
        [HttpGet]
        public ActionResult GetDetails(string searchString, string stateName,string stname, int? Page, int pageSize = 3)
        {
            Details obj = new Details();
            obj.pagesize = pageSize;
            int currentPage = Page ?? 1;
            int totalCount;

            IEnumerable<Details> model;

            model = _repository.GetPagedData(obj.pagesize, currentPage, out totalCount).ToList();
            if (!string.IsNullOrEmpty(stateName))
            {

                model = _repository.GetDetails1(stateName).ToList();
                ViewBag.States = _repository.GetStates();
                TempData["Data"] = model;
                var cities = _repository.GetCitiesByState(stateName).ToList();
                return Json(cities, JsonRequestBehavior.AllowGet);
                // return RedirectToAction("GetDetails", model);
                return View(model);
            }
            //if (!string.IsNullOrEmpty(stname))
            //{
            //    var cities = _repository.GetCitiesByState(stateName); 
            //    return Json(cities, JsonRequestBehavior.AllowGet);
            //}
            else
            {

                model = _repository.GetPagedData(obj.pagesize, currentPage, out totalCount).ToList();

            }
                if (!string.IsNullOrEmpty(searchString))
                {
                    model = model.Where(r => r.Name.Contains(searchString)).ToList();
                }
            

            int totalPages = (totalCount / pageSize);
            ViewBag.TotalCount = totalCount;
            ViewBag.PageSize = pageSize;
            ViewBag.TotalPages = totalPages;
            ViewBag.States = _repository.GetStates();
            return View(model);
        }
      //  in this we create the details cascading dropdownlist name ,email,mobile,stateid and cityid but if i click stateid and cityid corresponding cityname and statename 
         //   values will be assigned to table in database how you write join query with using city table and state table

        
        [HttpGet]
        public ActionResult Edit(int id)
        {
            
          //  var details = _repository.GetDetails(id);
            List<State> r1 = new List<State>();
            List<Details> r2 = new List<Details>();
            TempData["value"] = id;

            return View(_repository.GetDetails().Find(emp => emp.Id == id));

            ViewBag.States = new SelectList(_repository.GetStates(), "StateId", "StateName");

           
            //  ViewBag.Cities = new SelectList(_repository.GetCities(details.StateId), "CityId", "CityName", details.CityId);

          //  return View(details);
        }

 
        [HttpPost]
        public ActionResult Edit(int id,Details r)
        {
            _repository.Edit(id,r);
            return RedirectToAction("GetDetails");



        }
        [HttpPost]
        public ActionResult Delete(int id)
        {
            if (ModelState.IsValid)
            {
                _repository.Delete(id);
                return RedirectToAction("GetDetails");
            }
            return View();
        }



    }


    //public ActionResult GetDetails(string searchstring)
    //{
    //    if (!string.IsNullOrEmpty(searchstring))
    //    {
    //        model = model.Where(r => r.Name.Contains(searchstring)).ToList();
    //    }

    //    ModelState.Clear();
    //    return View(_repository.GetDetails());
    //}
}

