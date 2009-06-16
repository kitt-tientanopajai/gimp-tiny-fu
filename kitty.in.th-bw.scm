;; kitty.in.th-bw.scm
;; v. 0.07
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005-2008 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; This script converts an RGB image to a grayscale image using channel mixer.
;; Additionally, it could create effects of color filters and IR filter on
;; black and white film.
;;
;; ChangeLog
;; v.0.07 - Mon, 15 Dec 2008 22:37:06 +0700
;; - Move to Filters menu
;;
;; v.0.06 - Wed, 19 Nov 2008 01:04:54 +0700
;; - Scheme coding style

(define *filter-def*
	'(("None" 0)
		("Yellow" 1)
		("Orange" 2)
		("Red" 3)
		("Green" 4)
		("Infrared" 5)))

(define (kitty.in.th-bw image drawable filter)
	(gimp-image-undo-group-start image)
	(let* (
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image)))
		(image-layer (car (gimp-layer-new-from-drawable drawable image))))

		(gimp-layer-copy image-layer 1)
		(gimp-layer-set-name image-layer "kitty.in.th - grayscale")
		(gimp-image-add-layer image image-layer -1)

		(cond
			((= filter 0)
				(plug-in-colors-channel-mixer 1 image image-layer TRUE 0.3 0.59 0.11 0.3 0.59 0.11 0.3 0.59 0.11))
			((= filter 1)
				(plug-in-colors-channel-mixer 1 image image-layer TRUE 0.6 0.28 0.12 0.6 0.28 0.12 0.6 0.28 0.12))
			((= filter 2)
				(plug-in-colors-channel-mixer 1 image image-layer TRUE 0.78 0.22 0 0.78 0.22 0 0.78 0.22 0))
			((= filter 3)
				(plug-in-colors-channel-mixer 1 image image-layer TRUE 0.9 0.1 0 0.9 0.1 0 0.9 0.1 0))
			((= filter 4)
				(plug-in-colors-channel-mixer 1 image image-layer TRUE 0.1 0.7 0.2 0.1 0.7 0.2 0.1 0.7 0.2))
			((= filter 5)
				(plug-in-colors-channel-mixer 1 image image-layer TRUE 0.4 1.4 -0.8 0.4 1.4 -0.8 0.4 1.4 -0.8)))
					
		(gimp-curves-spline image-layer 0 8 (vector 0 0 64 60 192 196 255 255)))

	(gimp-image-undo-group-end image)
	(gimp-displays-flush))

(script-fu-register
	"kitty.in.th-bw"
	"<Image>/Filters/kitty.in.th/Black & White ..."
	"kitty.in.th Black & White v.0.07"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-OPTION "Filter:" (mapcar car *filter-def*))
