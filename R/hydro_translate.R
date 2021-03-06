
#' @title Translate Greek names and terms to English
#'
#' @description \code{hydro_translate} translates various Hydroscope's names and
#' terms to English.
#'
#' @param x a string vector
#' @param value One of the predefined values in
#' \code{c("owner", "variable", "timestep", "division")}
#'
#' @return If \code{value} is one of:
#' \itemize{
#' \item{\code{owner}, organizations' names.}
#' \item{\code{variable}, hydrometeorological term.}
#' \item{\code{timestep}, timestep term.}
#' \item{\code{division}, Water Division.}
#' }
#' returns a character vector with translations of various hydrometeorological
#' terms or organizations' names from Greek (with latin characters) to English.
#'
#' The organizations' names in \code{owner} are:
#'
#' \tabular{ll}{
#' \strong{Code}       \tab \strong{Name} \cr
#' min_envir_energy    \tab Ministry of Environment and Energy \cr
#' min_agricult        \tab Ministry of Rural Development and Food\cr
#' natio_meteo_service \tab National Meteorological Service  \cr
#' natio_observ_athens \tab National Observatory of Athens \cr
#' public_power_corp   \tab Public Power Corporation \cr
#' natio_argic_resear  \tab National Agricultural Research Foundation \cr
#' greek_perfectures   \tab Greek Prefectures \cr
#' crete_eng_faculty   \tab Technical University of Crete \cr
#' crete_natural_museum \tab Natural History Museum of Crete \cr
#' }
#'
#'
#' The Greek Water Divisions codes in \code{division} are:
#'
#' \tabular{ll}{
#' \strong{Code}  \tab \strong{Name} \cr
#' GR01 \tab Dytike Peloponnesos \cr
#' GR02 \tab Boreia Peloponnesos \cr
#' GR03 \tab Anatolike Peloponnesos \cr
#' GR04 \tab Dytike Sterea Ellada \cr
#' GR05 \tab Epeiros  \cr
#' GR06 \tab Attike  \cr
#' GR07 \tab Anatolike Sterea Ellada \cr
#' GR08 \tab Thessalia  \cr
#' GR09 \tab Dytike Makedonia  \cr
#' GR10 \tab Kentrike Makedonia  \cr
#' GR11 \tab Anatolike Makedonia  \cr
#' GR12 \tab Thrake  \cr
#' GR13 \tab Krete  \cr
#' GR14 \tab Nesoi Aigaiou  \cr
#' }
#'
#' @note
#' The dictionary used for the Greek to English translation is:
#'
#' \tabular{ll}{
#'  \strong{Transliterated term} \tab \strong{English term} \cr
#'   agnosto               \tab unknown           \cr
#'   anemos                \tab wind              \cr
#'   dieuthynse            \tab direction         \cr
#'   parelthon             \tab past              \cr
#'   tachyteta             \tab speed             \cr
#'   mese                  \tab average           \cr
#'   brochoptose           \tab precipitation     \cr
#'   diarkeia              \tab duration          \cr
#'   exatmise              \tab evaporation       \cr
#'   exatmisodiapnoe       \tab evapotranspiration\cr
#'   thermokrasia          \tab temperature       \cr
#'   edaphous              \tab ground            \cr
#'   bathos                \tab depth             \cr
#'   elachiste             \tab min               \cr
#'   megiste               \tab max               \cr
#'   piese                 \tab pressure          \cr
#'   semeiake              \tab point             \cr
#'   chioni                \tab snow              \cr
#'   ypsometro             \tab elevation         \cr
#'   stathme               \tab level             \cr
#'   plemmyra              \tab flood             \cr
#'   paroche               \tab flow              \cr
#'   broche                \tab precipitation     \cr
#'   katastase             \tab condition         \cr
#'   ektimemene            \tab estimation        \cr
#'   athroistiko           \tab cumulative        \cr
#'   stereo                \tab sediment          \cr
#'   ygrasia               \tab humidity          \cr
#'   ygro                  \tab wet               \cr
#'   apolyte               \tab absolute          \cr
#'   schetike              \tab relative          \cr
#'   asbestio              \tab calcium           \cr
#'   wetu                  \tab precipitation     \cr
#'   chionobrochometro     \tab snow_rain_gauge   \cr
#'   xero                  \tab dry               \cr
#'   ydrometrese           \tab flow_gauge        \cr
#'   thalasses             \tab sea               \cr
#'   semeio_drosou         \tab dew_point         \cr
#'   oratoteta             \tab visibility        \cr
#'   steria                \tab land              \cr
#'   thalassa              \tab sea               \cr
#'   barometro             \tab barometer         \cr
#'   tase_ydratmon         \tab vapour_pressure   \cr
#'   psychrometro          \tab psychrometer      \cr
#'   isodynamo_ypsos       \tab water_equivalent  \cr
#'   agogimoteta           \tab conductance       \cr
#'   aktinobolia           \tab radiation         \cr
#'   anthraka              \tab carbon            \cr
#'   dioxeidio             \tab dioxide           \cr
#'   ypoloipo              \tab residual          \cr
#'   argilio               \tab aluminum          \cr
#'   argilos               \tab clay              \cr
#'   arseniko              \tab arsenic           \cr
#'   pyritiou              \tab silicon           \cr
#'   aera                  \tab air               \cr
#'   nephokalypse          \tab cloud_cover       \cr
#'   nephose               \tab clouds            \cr
#'   axiosemeiota          \tab remarkably        \cr
#'   nephe                 \tab clouds            \cr
#'   kairos                \tab weather           \cr
#'   diafora               \tab difference        \cr
#'   atmosfairiki          \tab atmospheric       \cr
#'   stathera              \tab constant          \cr
#'   parousa               \tab present           \cr
#'   parelthousa           \tab past              \cr
#'   kalymeno              \tab cover             \cr
#'   el.                   \tab min               \cr
#'   meg.                  \tab max               \cr
#'   skleroteta            \tab hardness          \cr
#'   eliophaneia           \tab sunshine          \cr
#'   eisroe_se_tamieuteres \tab inflow_reservoir   \cr
#' }
#'
#'
#' @export hydro_translate
#'
#' @examples
#' \dontrun{
#'
#' # get data from the Ministry of Environment and Energy
#' kyy_owners <- get_owners("kyy")
#' kyy_vars <- get_variables("kyy")
#' owners_names <- hydro_translate(kyy_owners$name, "owner")
#' vars <- hydro_translate(kyy_vars$descr, "variable")
#' }
hydro_translate <- function(x,
                            value = c("owner", "variable", "timestep",
                                      "division")) {

  # match translate values
  value <- match.arg(value)

  # translate x
  switch (value,
          owner = map_owners(x),
          variable = map_variables(x),
          timestep = map_ts(x),
          division = map_wd(x))

}
