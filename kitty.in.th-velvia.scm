;; kitty.in.th-velvia.scm
;; v. 0.05
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005-2007 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script creates velvia-like effect
;;
;; ChangeLogs
;; v0.05 - Mon, 15 Dec 2008 22:40:12 +0700
;; - Move to Filters menu

(define (kitty.in.th-velvia image drawable gain)
	(let* (
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image)))
		(image-layer (car (gimp-layer-new-from-drawable drawable image)))
		(p-gain (/ gain 100))
		(s-gain (/ p-gain 2)))

		(gimp-image-undo-group-start image)

		(gimp-layer-copy image-layer 1)
		(gimp-layer-set-name image-layer "kitty.in.th velvia")
		(gimp-image-add-layer image image-layer -1)

		(plug-in-colors-channel-mixer 1 image image-layer FALSE 
			(+ 1 p-gain) (- 0 s-gain) (- 0 s-gain)
			(- 0 s-gain) (+ 1 p-gain) (- 0 s-gain)
			(- 0 s-gain) (- 0 s-gain) (+ 1 p-gain)
		)

		(gimp-curves-spline image-layer 0 8 (vector 0 0 64 60 192 196 255 255))
		
		(gimp-displays-flush)
		(gimp-image-undo-group-end image)))

(script-fu-register
	"kitty.in.th-velvia"
	"<Image>/Filters/kitty.in.th/Fuji Velvia..."
	"kitty.in.th Fuji Velvia/Provia v.0.05"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-ADJUSTMENT "Gain" '(20 -100 100 1 10 0 0))
