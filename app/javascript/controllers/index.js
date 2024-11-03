// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from 'controllers/application'
import { eagerLoadControllersFrom } from '@hotwired/stimulus-loading'
import ArticleController from './article_controller'

eagerLoadControllersFrom('controllers', application)
application.register('article', ArticleController)
